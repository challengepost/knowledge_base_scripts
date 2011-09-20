echo $(pwd)
git checkout master && git pull && \
  git submodule init && git submodule update && \
  ( \
    cd _site && git checkout master && git pull \
  ) && \
  gollum-site generate && \
  ( \
    cd _site && git checkout master && \
  ( \
    [[ 0 -eq "`git diff | wc -l`" ]] && echo "No changes." || git add . && git commit -m "Generated newest site." && git push \
  ) || echo "Positive reinforcement" \
) && \
( \
  [[ 0 -eq "`git diff | wc -l`" ]] && echo "No changes." || \
  ( \
    git commit -am "Updated _site" && git push \
  ) || echo "Positive reinforcement" \
)

