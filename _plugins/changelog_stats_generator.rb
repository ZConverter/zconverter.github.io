# frozen_string_literal: true

# changelog 통계 생성기
#
# _includes/zdm/ko/{prod}/changelog/{version}.md 본문을 스캔해
# BREAKING 항목 수를 세어 site.data.zdm.common.changelog_stats 에 주입한다.
#
#   site.data.zdm.common.changelog_stats["api"]["3.0.0"]["breaking"]  # => 13
#
# 세는 기준은 "본문 항목" 이다 — summary 한 줄에 적힌 (BREAKING) 태그가 아니라
# 본문의 `**BREAKING — …**` 소제목 개수. 두 값은 일치하지 않는다(summary 는
# 여러 변경을 하나로 묶어 적는다). 사용자가 실제로 확인해야 할 건수는 본문 쪽이다.
#
# 변경 '총' 건수는 일부러 세지 않는다. 본문 소제목의 분류 어휘가 통일돼 있지
# 않고(`신규` / `신규 엔드포인트` / `New Feature` …), `참고` · `예시` ·
# `연동 시 반드시 확인` 처럼 변경이 아닌 안내 항목이 섞여 있어 신뢰할 수 있는
# 수를 뽑을 수 없다. 분류 어휘가 정리되면 그때 추가한다.
module ZConverter
  class ChangelogStatsGenerator < Jekyll::Generator
    safe true
    priority :high

    PRODUCTS = %w[api cli].freeze

    # 본문 소제목: `**하위 호환 불가 — …**` (줄 전체가 강조인 형태). 옛 표기 `**BREAKING — …**` 도 계속 센다
    BREAKING_HEADING = /^\*\*(?:BREAKING\b|하위 호환 불가).*\*\*\s*$/i

    def generate(site)
      stats = {}

      PRODUCTS.each do |prod|
        dir = File.join(site.source, '_includes', 'zdm', 'ko', prod, 'changelog')
        next unless Dir.exist?(dir)

        per_version = {}
        Dir.glob(File.join(dir, '*.md')).each do |path|
          version = File.basename(path, '.md')
          body = strip_summary(File.read(path))
          per_version[version] = { 'breaking' => body.scan(BREAKING_HEADING).size }
        end
        stats[prod] = per_version
      end

      common = site.data.dig('zdm', 'common')
      common['changelog_stats'] = stats if common

      total = stats.values.sum { |v| v.values.sum { |s| s['breaking'] } }
      Jekyll.logger.info 'ChangelogStats:',
                         "#{stats.values.sum(&:size)} changelogs, #{total} BREAKING items"
    end

    private

    # 외곽 <summary> 안의 (BREAKING) 태그가 섞여 들어가지 않도록 본문만 남긴다.
    # (외곽 래퍼를 걷어낸 뒤에도 안전하게 동작한다)
    def strip_summary(text)
      idx = text.index('</summary>')
      idx ? text[(idx + 10)..] : text
    end
  end
end
