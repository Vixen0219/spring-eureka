#!/bin/sh

ENVDIR="$HOME/.env"
CONFIG="$ENVDIR/.config.hcl"

if [ ! -e $ENVDIR ]; then
  mkdir -p $ENVDIR
fi

cat <<EOF > $CONFIG
storage "s3" {
  access_key = "${VAULT_A_KEY}"
  secret_key = "${VAULT_S_KEY}"
  region = "${VAULT_REGION}"
  bucket = "${VAULT_BUCKET}"
}
listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 1
}
disable_mlock = 1
EOF

vault server -config $CONFIG
vault operator unseal ${VAULT_UNSEAL_KEY}
vault login ${VAULT_TOKEN}
