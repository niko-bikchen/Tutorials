subseq start end list =
  reverse (drop ((length list) - end) (reverse (drop start list)))
