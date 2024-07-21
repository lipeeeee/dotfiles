# Updates node version to latest
# needs Sudo (maybe -E too)
# requires npm

npm cache clean -f
npm install -g n
n stable
