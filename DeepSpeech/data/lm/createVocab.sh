python3 generate_lm.py --input_txt oo.txt.gz --output_dir . \
  --top_k 500000 --kenlm_bins ../../kenlm/build/bin/ \
  --arpa_order 5 --max_arpa_memory "85%" --arpa_prune "0|0|1" \
  --binary_a_bits 255 --binary_q_bits 8 --binary_type trie