IFS=$'\n'
policy_files=$(gittuf policy list-rules | grep '^\s*file:' | sed 's/^\s*file://')
json_files=$(ls | grep '.json')
failed=0
for file in $json_files
do
  if [[ ! (${policy_files[@]} =~ $file) ]]
  then
    echo "::error file=${file}::${file} has no gittuf policy owner"
    failed=1
  fi
done

if [[ $failed -eq 1 ]]; then
  echo "::error::One or more JSON files have no gittuf policy owner. Add rules with: gittuf policy add-rule"
  exit 1
fi

