#!/bin/sh
#===============================================================================
# 993_lldpd_config.sh - LLDP 协议配置
#===============================================================================

log_info() { echo "[INFO] $*"; }

configure_lldpd() {
    log_info "配置 lldpd..."

    if ! command -v lldpd >/dev/null 2>&1; then
        log_info "lldpd 未安装，跳过配置"
        return 0
    fi

    cat > /etc/config/lldpd << 'EOF'
config lldpd 'config'
    option enabled '1'
    option lldp_tx_interval '30'
    option lldp_tx_hold '4'
    option readonly_mode '0'
    option filter '0'
    option lldp_capability_advertisements '1'
    option lldp_mgmt_addr_advertisements '1'
    option enable_cdp '1'
    option enable_fdp '1'
    option enable_sonmp '1'
    option enable_edp '1'
    option force_lldp '1'
    option force_cdp '1'
    option force_cdpv2 '1'
    option force_fdp '1'
    option force_edp '1'
    option force_sonmp '1'
    option lldp_mgmt_ip '192.168.2.253'
EOF

    /etc/init.d/lldpd start 2>/dev/null
    /etc/init.d/lldpd enable 2>/dev/null

    log_info "lldpd 配置完成"
}

configure_lldpd
