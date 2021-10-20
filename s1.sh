#!/usr/bin bash -e
echo GIT CHECKOUT br2
git checkout -b br2
echo GIT config
git config --global user.email "Kannan_KVS@Dell.com"
git config --global user.name "kannankvs"
echo GIT pushOriginBr2
git push origin br2
echo '{ KVSK1-Prasanna1 - S1 - Try1' > s1.json
echo "\n}" >> s1.json
echo GIT add
git add s1.json
git commit -m "latest links for sonic images"
echo GIT last push
git push --set-upstream origin br2
