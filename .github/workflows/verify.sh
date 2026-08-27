IFS=$'\n'
policy_files=$(gittuf policy list-rules | grep '^\s*file:' | sed 's/^\s*file://')
json_files=$(ls | grep '.json')
for file in $json_files
do
  if [[ ! (${policy_files[@]} =~ $file) ]]
  then
    echo "$file not in policy file"
    exit 1
  fi
done

