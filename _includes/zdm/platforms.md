{%- if include.desc %}
| 값 | 설명 |
|------|------|
| `oci` | Oracle Cloud Infrastructure |
| `ncp` | Naver Cloud Platform |
| `gcp` | Google Cloud Platform |
| `aws` | Amazon Web Services |
| `azure` | Microsoft Azure |
| `vmware` | VMware vSphere |
| `scp` | Samsung Cloud Platform |
| `openstack` | OpenStack |
| `cloudstack` | Apache CloudStack |
| `kt` | KT Cloud |
| `nhn` | NHN Cloud |
| `nutanix` | Nutanix |
| `proxmox` | Proxmox VE |
| `kvm` | KVM |
| `hyperv` | Microsoft Hyper-V |
| `xenserver` | Citrix XenServer |
{% if include.baremetal %}| `baremetal` | 베어메탈 (CLI only) |
{% endif -%}
{%- elsif include.inline -%}
`oci`, `ncp`, `gcp`, `aws`, `azure`, `vmware`, `scp`, `openstack`, `cloudstack`, `kt`, `nhn`, `nutanix`, `proxmox`, `kvm`, `hyperv`, `xenserver`{% if include.baremetal %}, `baremetal`{% endif %}
{%- else %}
| 플랫폼 |
|--------|
| `oci` |
| `ncp` |
| `gcp` |
| `aws` |
| `azure` |
| `vmware` |
| `scp` |
| `openstack` |
| `cloudstack` |
| `kt` |
| `nhn` |
| `nutanix` |
| `proxmox` |
| `kvm` |
| `hyperv` |
| `xenserver` |
{% if include.baremetal %}| `baremetal` |
{% endif -%}
{%- endif -%}