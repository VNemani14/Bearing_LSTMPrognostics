# Bearing_LSTMPrognostics
This repository contains parts of code for the publication "Ensembles of Probabilistic LSTM Predictors and Correctors for Bearing Prognostics Using Industrial Standards" by Nemani et al. in Neurocomputing 

We use publicly available XJTU-SY bearing run-to-failure dataset 
[Biao Wang et al. “A Hybrid Prognostics Approach for Estimating Remaining Useful Life of Rolling Element Bearings”, IEEE Transactions on Reliability](https://ieeexplore.ieee.org/document/8576668)

Brief description of the provided code/data

- `convert_acceleration_to_velocity.m`: MATLAB file to convert the original vibration signals in acceleration domain to velocity domain
- `get_velocity_feature.m`: MATLAB file for feature extraction from the velocity domain. The feaures are explained in detail in the paper
- `LSTM_MCDopout.ipynb`: MC Dropout implementation for bearing prognostics using an extracted feature representing the bearing health.  

The corresponding data repositories can be downloaded at: https://data.mendeley.com//datasets/mpn45f4gxc/1
- `originaldata` contains the vibration data in .mat files. These are obtained from the original XJTU-SY Dataset with csv files: https://github.com/WangBiaoXJTU/xjtu-sy-bearing-datasets
- `processeddata` contains vibration data processed into velocity domain and features extracted


NOTE: Please contact Prof. Chao Hu, chaohu@iastate.edu, for any questions. 
