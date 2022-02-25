# RegisterMRIDataForDeepLearning

FSL registration of examples volumes for deep learning

```bash
% tree data
data
├── FLAIR_FLAIR_0_6.nii.gz
├── T1wCE_T1wCE_0_1100.nii
├── T1wCE_T1wCE_0_1100.nii.gz
├── T1w_T1w_0_4.nii.gz
└── T2w_T2w_0_500.nii.gz
% ./register.sh data/ data/T1w_T1w_0_4.nii.gz /tmp/regs
...
% ls -l /tmp/regs 
total 22648
-rw-r--r--  1 wheel  2816707 Feb 25 14:14 FLAIR_FLAIR_0_6.nii_to_T1w_T1w_0_4.nii.nii.gz
-rw-r--r--  1 wheel  3037650 Feb 25 14:20 T1wCE_T1wCE_0_1100.nii_to_T1w_T1w_0_4.nii.nii.gz
-rw-r--r--  1 wheel  3037650 Feb 25 14:17 T1wCE_T1wCE_0_1100_to_T1w_T1w_0_4.nii.nii.gz
-rw-r--r--  1 wheel  2696166 Feb 25 14:11 reference_T1w_T1w_0_4.nii_1x1x1.nii.gz
```
