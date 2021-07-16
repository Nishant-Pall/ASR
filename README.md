# Automatic Speech Recognition

## Objective

   To use the Deepspeech model from Mozilla, and use it extensively for identifying the software engineering jargon to assist developers in sorting issues and debug their code.

## Contents

### Resources

   * [Deepspeech Documentation](https://deepspeech.readthedocs.io/en/r0.9/)
   * [Deepspeech Paper](https://arxiv.org/abs/1412.5567)
   * [KenLM Library](https://github.com/kpu/kenlm)
   * Scripts obtained from [Object-Oriented-Design](https://www.coursera.org/learn/object-oriented-design) from the University of Alberta on Coursera, and
   * [Server-Side Development](https://www.coursera.org/learn/server-side-nodejs?specialization=full-stack-react) from The Hong Kong University of Science and Technology.

### Formatting

   * Back-End Web development text [scripts](Scripts/backendscripts/back-end-script.txt).
   * Object Oriented Design text [scripts](Scripts/Object%20Oriented%20Design/OO.txt).

 *   Notebooks for appropriate formatting and work up to make scripts suitable for training a scorer have been named according to their function.

### Building Scorer

  *  Scorers were built [here](/DeepSpeech/data/lm).

  * Follow the [External Scorer Scripts](https://deepspeech.readthedocs.io/en/v0.9.3/Scorer.html) documentation for building and training your own scorers according to the dataset.

 * STEPS TO BUILD A SCORER

   * Gzip the [OO.txt](Scripts/Object%20Oriented%20Design/OO.txt) to [oo.txt.gz](DeepSpeech/data/lm/oo.txt.gz) using

   ```
     gzip OO.txt
   ```

   * Build the [KenLM](https://kheafield.com/code/kenlm/) Library.

   * Use the following command to build the lm.binary and vocab.txt, as done in [createVocab.sh](DeepSpeech/data/lm/createVocab.sh).

   ```
    python3 generate_lm.py 
    --input_txt oo.txt.gz 
    --output_dir . \
    --top_k 500000 
    --kenlm_bins ../../kenlm/build/bin/ \
    --arpa_order 5 
    --max_arpa_memory "85%" 
    --arpa_prune "0|0|1" \
    --binary_a_bits 255 
    --binary_q_bits 8 
    --binary_type trie
   ```

    * To build the scorer, run the following command, as done in [build.sh](DeepSpeech/data/lm/build.sh)
    * Fine tune values of parameters `default_alpha` and `default_beta` for obtaining signals appropriately.

   ```
    ./generate_scorer_package
    --alphabet ../alphabet.txt
    --lm lm.binary 
    --vocab vocab-500000.txt \ 
    --package kenlm.scorer
    --default_alpha 0.93
    --default_beta 1.18 
    --force_bytes_output_mode True
   ```

### Testing

* Audio file obtained from [Object-oriented Programming in 7 minutes | Mosh](https://www.youtube.com/watch?v=pTB0EiLXUC8).

* Used [convert.ipynb](Testing/convert.ipynb) for extracting the audio from the video and converting it into .wav format.

* To obtain the result script and store it into [result.txt](Testing/result.txt) run the following command in terminal.

    ```
    deepspeech --model deepspeech-0.9.3-models.pbmm --scorer kenlm.scorer --audio OO.wav > result.txt

    ```
