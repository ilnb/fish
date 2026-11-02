function memcheck
  if not command -qs smem
    echo "Install smem"
    return 1
  end

  if test (count $argv) -eq 0
    echo "Usage: memcheck <process-name>"
    return 1
  end

  smem -P "$argv[1]" | awk 'NR>1 {
    uss+=$5; pss+=$6; rss+=$7;
  } END {
    printf "USS: %.2fM\nPSS: %.2fM\nRSS: %.2fM\n", uss/1024, pss/1024, rss/1024
  }'
end
