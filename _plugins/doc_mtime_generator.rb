# frozen_string_literal: true
#
# doc_mtime_generator.rb
#
# 빌드 시점에 각 CLI/API 버전의 "문서 마지막 갱신일"을 git history 기반으로 계산해
# `site.data["zdm"]["common"]["doc_mtimes"]`에 주입한다.
#
# 추적 대상 — 제품별 문서 파트에 속한 .md 파일만 추적:
#   wrapper(`zdm/ko/{prod}/{docs}/**/*.md`)는 어떤 _includes를 가리키는지 알아내는
#   "라우팅" 용도로만 파싱하고 **mtime 계산에는 포함하지 않는다**.
#   wrapper가 transitive로 include하는 파일 중
#   **`_includes/zdm/ko/{prod}/` 하위에 있는 .md만** 추적 대상으로 잡고,
#   공통 include(`_includes/zdm/*.md` 등 cli/api 디렉토리 밖)는 의도적으로 무시한다.
#
# wrapper 자체의 변경(include 경로 보정 등 라우팅 변경)도 의도적으로 제외한다.
# `_data/*.yml`(공통 enum 등)은 마크다운이 아니므로 본 Generator로는 추적되지 않는다.
#
# 자동 추출이 실패하거나 부정확하면 versions.yml의 수동 `docs_updated` 값이 fallback으로 사용된다.

require "set"
require "open3"
require "time"

module ZdmDocMtime
  INCLUDE_RE = /\{%\s*include\s+([^\s%]+?\.md)/.freeze
  WRAPPER_GLOB = "zdm/ko/%<prod>s/%<docs>s/**/*.md"
  INCLUDES_ROOT = "_includes"

  class << self
    def git_commit_time(repo_root, path)
      rel = path.sub(%r{\A#{Regexp.escape(repo_root)}/}, "")
      out, status = Open3.capture2("git", "-C", repo_root, "log", "-1", "--format=%ct", "--", rel)
      return nil unless status.success?
      ts = out.strip
      ts.empty? ? nil : ts.to_i
    end

    # 한 파일이 가리키는 _includes 파일 집합을 transitive하게 수집한다.
    # `allowed_prefix`(예: "_includes/zdm/ko/api/")로 시작하는 파일만 결과에 포함.
    # 공통 include는 라우팅 추적(seen)에는 들어가지만 결과 set에는 들어가지 않는다.
    # `self_path`는 결과에 포함되지 않는다(라우팅용으로만 사용).
    def collect_transitive_includes(self_path, repo_root, seen, allowed_prefix)
      return Set.new if seen.include?(self_path) || !File.file?(self_path)
      seen << self_path

      collected = Set.new
      content = File.read(self_path)
      content.scan(INCLUDE_RE).flatten.each do |inc_rel|
        inc_path = File.join(repo_root, INCLUDES_ROOT, inc_rel)
        next unless File.file?(inc_path)
        rel = inc_path.sub(%r{\A#{Regexp.escape(repo_root)}/}, "")
        # 공통 include(cli/api 디렉토리 밖)는 결과에 넣지 않지만,
        # 그 안의 include는 따라가지 않는다 (사용자 규칙: 공통은 추적 무시).
        if rel.start_with?(allowed_prefix)
          collected << inc_path
          collected.merge(collect_transitive_includes(inc_path, repo_root, seen, allowed_prefix))
        end
      end
      collected
    end

    def compute_for_version(repo_root, prod, version_entry)
      docs_ver = version_entry["docs"] || version_entry["version"]
      wrapper_glob = File.join(repo_root, format(WRAPPER_GLOB, prod: prod, docs: docs_ver))
      wrappers = Dir.glob(wrapper_glob)
      return nil if wrappers.empty?

      allowed_prefix = "#{INCLUDES_ROOT}/zdm/ko/#{prod}/"
      included = Set.new
      seen = Set.new
      wrappers.each { |w| included.merge(collect_transitive_includes(w, repo_root, seen, allowed_prefix)) }
      return nil if included.empty?

      timestamps = included.map { |f| git_commit_time(repo_root, f) }.compact
      return nil if timestamps.empty?

      Time.at(timestamps.max).strftime("%Y-%m-%d")
    end
  end
end

module Jekyll
  class DocMtimeGenerator < Generator
    safe false
    priority :high

    def generate(site)
      repo_root = site.source
      versions = site.data.dig("zdm", "common", "versions") || {}
      result = { "api" => {}, "cli" => {} }

      %w[api cli].each do |prod|
        (versions[prod] || []).each do |v|
          ver = v["version"]
          next unless ver
          mtime = ZdmDocMtime.compute_for_version(repo_root, prod, v)
          result[prod][ver] = mtime if mtime
        end
      end

      site.data["zdm"] ||= {}
      site.data["zdm"]["common"] ||= {}
      site.data["zdm"]["common"]["doc_mtimes"] = result

      Jekyll.logger.info "DocMtime:", "computed #{result['api'].size} api + #{result['cli'].size} cli entries"
    end
  end
end
