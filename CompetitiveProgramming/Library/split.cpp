vector<string> split(string s) {
    vector<string> tokens;
    set<char> char_to_remove = {' ', ','};
    s = s + (*char_to_remove.begin());
    string token;
    for (auto c : s) {
        if (char_to_remove.find(c) == char_to_remove.end()) {
            token.push_back(c);
        } else if (token.size() > 0) {
            tokens.push_back(token);
            token.clear();
        }
    }
    return tokens;
}