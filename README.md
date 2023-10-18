### 🌎 Cancer Genomics &nbsp; &nbsp; &nbsp; 🔍 Structural Variants &nbsp; &nbsp; &nbsp; 📈 Long-Read Sequencing

Prostate cancer is an important medical concern and understanding malignancy is essential for providing therapies and treatments to patients. In the United States, it is the second most common cancer with over 250,000 new cases having been reported in 2022, and the fifth leading cause of cancer death (NIH National Cancer Institute). For patients with metastatic castration-resistant prostate cancer, there are currently no curative therapies available. To understand prostate cancer malignancy and inform treatment development, the goal of this project was to characterize structural variants in prostate cancer genomes by comparing genomic rearrangements identified using short-read and long-read sequencing data.

![PDX Models](https://github.com/kbfeldmann/LuCaP_SVs/assets/47021794/7f0ee77e-973c-4be0-a45d-61dc4ab03a94)
**Figure 1:** *Diagram of using a PDX model for short-read and long-read genomic samples. Prostate cancer tumor tissue was collected from a patient, and tumor tissue material was increased in mouse models before sequencing. Note: short-read and long-read samples were collected from different mice.*

The majority of cancer genomes available for identifying structural variants - genomic alterations larger than 50 base pairs - are paired-end, short-read. However, there are numerous limitations to using paired-end, short-read sequencing data for identifying structural variants. Due to the shorter length of the reads (2 X 150 bp), these limitations include not being able to uniquely map to repetitive regions in the reference genome and an inability to determine if structural variants are on the same chromosome. Alternatively, long-reads (>10 KB) are able to align to larger sections of the reference genome and can resolve many of these limitations. However, the use of long-reads in research has been limited by sequencing cost, nucleotide accuracy and sample requirements.

**Research Question:** *How do genomic rearrangements compare between short-read and long-read sequencing data in prostate cancer genomes?*

Despite comparing structural variants identified by three different long-read variant callers (i.e., intersection) to the structural variants identified by one short-read variant caller, long-reads identified more germline and non-germline structural variants than short-reads. These additional structural variants are either unknown genomic rearrangements, variants that occurred between passages or germline variants. Despite attempting to remove germline variants using Sniffles, some of these additional structural variants may be germline because our long-read prostate cancer PDX models were not paired with a normal sample.

To learn more, check out my presentation for early-career molecular biologists: [click here](Winter_Rotation_Presentation.pdf)

## Bioinformatics Pipelines

```
# Short-read structural variant calling tools.
/Call_Variants/svaba/svaba.sh
/Call_Variants/gridss/gridss.sh # Not used for comparison.
```

![Short-Read](https://github.com/kbfeldmann/LuCaP_SVs/assets/47021794/4a476426-a1eb-4ac7-b9ed-25f5780e2836)
**Figure 2:** *Brief pipeline describing how structural variants were called for short-read sequencing data. The red box identifies the normal (i.e., non-tumor) sample that was used to remove germline variants. Italicized text at the top of each box indicates the program used to complete the task.*

```
# Long-read structural variant calling tools.
/Call_Variants/sniffles/sniffles.sh
/Call_Variants/svdss/svdss.sh
/Call_Variants/svim/svim.sh

# Tool used to merge long-read structural variants (i.e., structural variants identified by ALL callers).
/Merge_Variants/jasmine/jasmine.sh
```

![Long-Read](https://github.com/kbfeldmann/LuCaP_SVs/assets/47021794/f12ffe2b-5451-4a62-8ca4-fe7b2102c537)
**Figure 3:** *Brief pipeline describing how structural variants were called for long-read sequencing data. There was no normal (i.e., non-tumor) sample to remove germline variants (red box). Italicized text at the top of each box indicates the program used to complete the task.*
