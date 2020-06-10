#!/bin/sh

# codec_resample: allows re-sampling of Signed Linear into different sampling rates 12,16,24,32,44,48,96 or 192 kHz to aid translation.
# func_channel: required by res_hep to sen statistics
# pbx_config: used for dialplan config

set -e

cd /tmp/asterisk/
make menuselect.makeopts \
    && menuselect/menuselect --disable-all \
    --enable app_dial \
    --enable app_echo \
    --enable app_senddtmf \
    --enable chan_pjsip \
    --enable codec_alaw \
    --enable codec_g722 \
    --enable codec_gsm \
    --enable codec_ilbc \
    --enable codec_opus \
    --enable codec_resample \
    --enable codec_speex \
    --enable format_gsm \
    --enable format_ilbc \
    --enable format_pcm \
    --enable func_channel \
    --enable MOH-OPSOUND-ALAW \
    --enable MOH-OPSOUND-G722 \
    --enable MOH-OPSOUND-GSM \
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
