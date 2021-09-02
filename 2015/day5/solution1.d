import std;

void main() {
  auto inputs = readText("./input.txt").splitLines.array;

  inputs.map!(s => vowelCheck(s, 3) && twiceCheck(s) && badStringCheck(s)).array.count(true).writeln;
}

bool vowelCheck(string s, int n) {
  return count!(a => ['a','e','i','o','u'].canFind(a))(s) >= n;
}

bool twiceCheck(string s) {
  return zip(s, s.dropOne).array.any!(x => x[0] == x[1]);
}

bool badStringCheck(string s) {
  auto bad = ["ab", "cd", "pq", "xy"];
  foreach(b; bad) {
    if (s.canFind(b)) {
      return false;
    }
  }
  return true;
}
