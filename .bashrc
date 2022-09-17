function updateCTags() {
    find . -type f -regex ".*\.[ch]" > ctagsfilelist
    find . -type f -regex ".*\.cpp" >> ctagsfilelist
    find . -type f -regex ".*\.hpp" >> ctagsfilelist
    ctags -L ctagsfilelist
}

function updateCScope() {
    find . -type f \( -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.cpp" \) > cscope.files
    cscope -q -b -k
}


