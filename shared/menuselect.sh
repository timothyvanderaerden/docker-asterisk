#!/bin/sh
set -e

cd /tmp/asterisk/
make menuselect.makeopts \
    && menuselect/menuselect --disable-all \
    --enable app_dial \
    --enable app_echo \
    --enable app_senddtmf \
    --enable chan_pjsip \
    --enable codec_alaw \
    --enable format_pcm \
    --enable func_channel \
    --enable MOH-OPSOUND-ALAW \
    --enable pbx_config \
    --enable res_hep \
    --enable res_hep_pjsip \
    --enable res_hep_rtcp \
    --enable res_musiconhold \
    --enable res_pjproject \
    --enable res_pjsip \
    --enable res_pjsip_authenticator_digest \
    --enable res_pjsip_endpoint_identifier_user \
    --enable res_pjsip_registrar \
    --enable res_pjsip_sdp_rtp \
    --enable res_rtp_asterisk \
    --enable res_statsd \
    menuselect.makeopts
