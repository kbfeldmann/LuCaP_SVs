### 🌎 Cancer Genomics &nbsp; &nbsp; &nbsp; 🔍 Structural Variants &nbsp; &nbsp; &nbsp; 📈 Long-Read Sequencing

**-----Insert introduction-----**

![PDX Models](https://github.com/kbfeldmann/LuCaP_SVs/assets/47021794/7f0ee77e-973c-4be0-a45d-61dc4ab03a94)
**Figure 1:** *Diagram of using a PDX model for short-read and long-read genomic samples. Prostate cancer tumor tissue was collected from a patient, and tumor tissue material was increased in mouse models before sequencing. Note: short-read and long-read samples were collected from different mice.*

**-----Continue introduction-----**

**Research Question:** *How do genomic rearrangements compare between short-read and long-read sequencing data in prostate cancer genomes?*

**-----Insert findings-----**

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
