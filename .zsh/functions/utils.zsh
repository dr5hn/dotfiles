# ~/.zsh/functions/utils.zsh
# Utility functions

# WiFi password lookup
wifi() {
    security find-generic-password -wa "$1" | grep password: | cut -d '"' -f 2
}

# URL redirect checker
redirectby() {
    curl -I "$1" | grep redirect
}

# EDD License POST method
edd-license-post() {
    local license_key="$1"
    local item_name="$2"
    local source_url="$3"
    local endpoint_url="$4"

    curl -s -d "edd_action=get_version&license=${license_key}&item_name=${item_name}&url=${source_url}" "${endpoint_url}"
}

# EDD License GET method
edd-license-get() {
    local license_key="$1"
    local item_name="$2"
    local source_url="$3"
    local endpoint_url="$4"

    curl -s \
        --get \
        --data-urlencode "edd_action=get_version" \
        --data-urlencode "license=${license_key}" \
        --data-urlencode "item_name=${item_name}" \
        --data-urlencode "url=${source_url}" \
        "${endpoint_url}"
}

# Add path comments to files in a directory
add-path-comments() {
    if [ -z "$1" ]; then
        echo "Usage: add-path-comments <directory_path>"
        return 1
    fi

    local BASE_DIR="$1"

    if [ ! -d "$BASE_DIR" ]; then
        echo "Error: Directory '$BASE_DIR' does not exist"
        return 1
    fi

    cd "$BASE_DIR" || return 1

    find . -type f | while read -r FILE; do
        if file "$FILE" | grep -q "text"; then
            echo "Processing: $FILE"

            local COMMENT="#"
            local COMMENT_END=""

            if [[ "$FILE" == *.cpp ]] || [[ "$FILE" == *.c ]] || [[ "$FILE" == *.h ]] || [[ "$FILE" == *.java ]] || [[ "$FILE" == *.js ]] || [[ "$FILE" == *.ts ]] || [[ "$FILE" == *.cs ]]; then
                COMMENT="//"
            elif [[ "$FILE" == *.html ]] || [[ "$FILE" == *.xml ]]; then
                COMMENT="<!--"
                COMMENT_END=" -->"
            elif [[ "$FILE" == *.css ]]; then
                COMMENT="/*"
                COMMENT_END=" */"
            elif [[ "$FILE" == *.sql ]]; then
                COMMENT="--"
            fi

            local TEMP_FILE=$(mktemp)
            echo "${COMMENT} ${BASE_DIR}/$(echo "$FILE" | sed 's|^\./||')${COMMENT_END}" > "$TEMP_FILE"
            cat "$FILE" >> "$TEMP_FILE"
            mv "$TEMP_FILE" "$FILE"
        else
            echo "Skipping binary file: $FILE"
        fi
    done

    echo "Done! Added relative path comments to all text files in $BASE_DIR"
    cd - > /dev/null
}
alias apc='add-path-comments'
