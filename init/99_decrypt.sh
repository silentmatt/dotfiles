# Decrypt private files
# Encryption command:
#   gpg --encrypt --sign --armor -r email@matthewcrumley.com [DOTFILE]

function decrypt() {
  local enc_path
  if [[ -f "$1.asc" ]]; then
    enc_path="$1.asc"
  elif [[ -f "$1.gpg" ]]; then
    enc_path="$1.gpg"
  fi

  if [[ "$enc_path" ]]; then
    if [[ -f "$enc_path" ]]; then
      if [[ -e "$1" ]]; then
        e_error "Not decrypting: $1 already exists"
      else
        e_success "Decrypting $1"
        gpg --decrypt -i -o "$1" "$enc_path" 2>/dev/null || e_error "Error decrypting $1"
      fi
    else
      e_error "Skipping $1"
    fi
  fi
}

e_header "Decrypting files"
decrypt ~/.pgpass
decrypt ~/.netrc
decrypt ~/.ssh/id_rsa
decrypt ~/.ssh/id_rsa.pub

chmod 600 ~/.pgpass || e_error "Error setting file permissions for ~/.pgpass"
chmod 600 ~/.netrc || e_error "Error setting file permissions for ~/.netrc"
chmod 600 ~/.ssh/id_rsa || e_error "Error setting file permissions for ~/.ssh/id_rsa"
chmod 644 ~/.ssh/id_rsa.pub || e_error "Error setting file permissions for ~/.ssh/id_rsa"
