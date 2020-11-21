class CommonFunctions {
  getMapLengthWhereNotNull(Map a) {
    int l = 0;
    a.forEach((key, value) {
      if (value != null) l++;
    });
    return l;
  }
}
