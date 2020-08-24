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
        chmod --reference="$enc_path" "$1" || e_error "Error setting file permissions for $1"
      fi
    else
      e_error "Skipping $1"
    fi
  fi
}

e_header "Decrypting files"
decrypt ~/.pgpass
