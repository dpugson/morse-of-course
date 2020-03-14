git filter-branch --env-filter 'if [ true ]; then
     GIT_AUTHOR_EMAIL=dougal.pugson@gmail.com;
     GIT_AUTHOR_NAME="Dougal Pugson";
     GIT_COMMITTER_EMAIL=dougal.pugson@gmail.com;
     GIT_COMMITTER_NAME="Dougal Pugson"; fi' -- --all

