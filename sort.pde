void sortScore(int score[]) {
  boolean flag = true;
  int tmp;

  while (flag) {
    flag = false;    
    for ( int j=0; j<score.length - 1; j++ ) {
      if ( score[ j ] < score[j+1] ) {
        tmp = score[j];                
        score[j] = score[j+1];
        score[j+1] = tmp;
        flag = true;
      }
    }
  }
} 