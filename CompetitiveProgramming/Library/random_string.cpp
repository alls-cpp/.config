string random_string(int n) {
    string low = "abcdefghijklmnopqrstuvwxyz";
    string up = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    string d = "1234567890";
    string alphabet = low;
    string res = "";
    for (int i = 0; i < n; ++i) {
        res.push_back(alphabet[uid(1, alphabet.size()) - 1]);
    }
    return res;
}
