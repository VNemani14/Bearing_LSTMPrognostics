# Bearing_LSTMPrognostics
This repository contains parts of code for the publication "Ensembles of Probabilistic LSTM Predictors and Correctors for Bearing Prognostics Using Industrial Standards" by Nemani et al. in Neurocomputing 

We use publicly available XJTU-SY bearing run-to-failure dataset 
Biao Wang, Yaguo Lei, Naipeng Li, Ningbo Li, “A Hybrid Prognostics Approach for Estimating Remaining Useful Life of Rolling Element Bearings”, IEEE Transactions on Reliability, vol. 69, no. 1, pp. 401-412, 2020.

Brief description of the provided code/data
1) originaldata contains the vibration data in .mat files
2) processeddata contains vibration data processed into velocity domain and features extracted
3) convert_acceleration_to_velocity.m: MATLAB file to convert the original vibration signals in acceleration domain to velocity domain
4) get_velocity_feature.m: MATLAB file for feature extraction from the velocity domain. The feaures are explained in detail in the paper
5) LSTM_MCDopout.ipynb: MC Dropout implementation for bearing prognostics using an extracted feature representing the bearing health.  


