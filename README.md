# Ovaj projekat je realizovan u master rada: " ", na Biološkom fakultetu Univerziteta u Beogradu.

``` 
master_rad/
├── data/ # Ulazni podaci za skripte
    └── GHSI_2021_large_table.csv/ # Podaci iz 2021. godine
    └── mr_GHSI_demo_data_transf_out.csv/ # Podaci iz 2019. godine
    └── GHSI_2021_transformed_data.mat/ # Transformisani podaci iz 2021. godine
    └── PCA_data.mat/ # Izlazni podaci PCA
    └── PC_vs_mr_tables.mat/ # Izlazni podaci korelacije PCs i mr
    └── noPC_vs_mr_tables.mat/ # Izlazni podaci korelacije varijabli koje nisu usle u PCA i m/r
    └── significant_corr.mat/ # Znacajni (p<0.05) izlazni podaci korelacije
    └──t bl_2019.mat/ # Objedinjeni podaci znacajnih PCs i varijabli koje nisu usle u PCA za 2019. godinu
    └── tbl_2021.mat/ # Objedinjeni podaci znacajnih PCs i varijabli koje nisu usle u PCA za 2021. godinu

├── funkcije/ # Folder sa funkcijama
    └── DnRoutlier.mat/ # Funkcija koja trazi i zamenjuje autlajere medijanom date kolone
    └── pcs_treshold.mat/ # Funckija koja trazi broj PCs koje kumulativno daju 85% objasnjenih podata

├── imgs/ # Folder sa slikama
├──RF_modeli/ # Folder sa Random Forest modelima za razlicite godine
    └── RF_2019/ # Random Forest model treniran na podacima tbl_2019
    └── RF_2021/ # Random Forest model treniran na podacima tbl_2021
    └── RF_2021_red/ # Random Forest model treniran na podacima tbl_2021 izuzev kolone GHSI_2021_PC1

├── GHSI_2021_transformation.m/ # Kod i skripte za transformaciju podataka iz GHSI_2021_large_table.csv
├── PCA.m/ # Kod i skripte za PCA
├── korelaciona_analiza.m/ # Kod i skripte za izvodjenje korelacione analize izlaznih podataka PCA
├── RF.m/ # Kod i skripte za treniranje Random Forest modela
├── Vizuelizacija.m/ # Kod i skripte za vizuelizaciju rezultata Random Forest modela
└── README.md # Opis projekta
``` 

## Tehnologije
``` 
- MATLAB
- Git i GitHub za verzionisanje koda
``` 
## Autor
``` 
Mihajlo Mladenović 
Master studije : Biofizika sa računarskom biologijom
Univerzitet u Beogradu, Biološki fakultet  
Email: b1018_2024@stud.bio.bg.ac.rs
``` 
