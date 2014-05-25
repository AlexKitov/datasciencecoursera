|    | names.tidydata.                   | type    | range        |                    | description                                                                               |
|----|-----------------------------------|---------|--------------|--------------------|-------------------------------------------------------------------------------------------|
| 1  | activity                          | factor  |              | laying             | The name of the activity performed by te subject for each set of measurements             |
|    |                                   |         |              | sitting            |                                                                                           |
|    |                                   |         |              | standing           |                                                                                           |
|    |                                   |         |              | walking            |                                                                                           |
|    |                                   |         |              | walking.downstairs |                                                                                           |
|    |                                   |         |              | walking.upstairs   |                                                                                           |
|    |                                   |         |              |                    |                                                                                           |
| 2  | subject                           | factor  |              | 1 until 30         | the subject who performed the activity. There were 30 subjects from different age and sex |
|    |                                   |         |              |                    |                                                                                           |
|    |                                   |         | min value    | max value          |                                                                                           |
| 3  | tbodyaccmeanx                     | numeric | 0.2215982    | 0.301461           | the mean acceleration of the body time samples by "x" axis                                |
| 4  | tbodyaccmeany                     | numeric | -0.001308288 | -0.040513953       | the mean acceleration of the body time samples by "y" axis                                |
| 5  | tbodyaccmeanz                     | numeric | -0.07537847  | -0.1525139         | the mean acceleration of the body time samples by "z" axis                                |
| 6  | tbodyaccstdx                      | numeric | -0.008659219 | 0.626917071        | the standard deviation of the body acceleration time samples by "x" axis                  |
| 7  | tbodyaccstdy                      | numeric | -0.002320265 | 0.616937015        | the standard deviation of the body acceleration time samples by "y" axis                  |
| 8  | tbodyaccstdz                      | numeric | -0.0077153   | 0.60901788         | the standard deviation of the body acceleration time samples by "z" axis                  |
| 9  | tgravityaccmeanx                  | numeric | -0.134832    | 0.9745087          | the mean gravity acceleration time samples by "x" axis                                    |
| 10 | tgravityaccmeany                  | numeric | -0.002814673 | 0.956593814        | the mean gravity acceleration time samples by "y" axis                                    |
| 11 | tgravityaccmeanz                  | numeric | -0.001993106 | 0.957873042        | the mean gravity acceleration time samples by "z" axis                                    |
| 12 | tgravityaccstdx                   | numeric | -0.8295549   | -0.9967642         | the standard deviation of the gravity acceleration time samples by "x" axis               |
| 13 | tgravityaccstdy                   | numeric | -0.6435784   | -0.9942476         | the standard deviation of the gravity acceleration time samples by "y" axis               |
| 14 | tgravityaccstdz                   | numeric | -0.6101612   | -0.9909572         | the standard deviation of the gravity acceleration time samples by "z" axis               |
| 15 | tbodyaccjerkmeanx                 | numeric | 0.0426881    | 0.13019304         | the mean jerk acceleration of the body time samples by "x" axis                           |
| 16 | tbodyaccjerkmeany                 | numeric | -1.09E-02    | 9.91E-03           | the mean jerk acceleration of the body time samples by "y" axis                           |
| 17 | tbodyaccjerkmeanz                 | numeric | -1.00E-02    | 9.42E-03           | the mean jerk acceleration of the body time samples by "z" axis                           |
| 18 | tbodyaccjerkstdx                  | numeric | -0.003583389 | 0.544273037        | the standard deviation of the body jerk acceleration time samples by "x" axis             |
| 19 | tbodyaccjerkstdy                  | numeric | -0.01235011  | 0.355306717        | the standard deviation of the body jerk acceleration time samples by "y" axis             |
| 20 | tbodyaccjerkstdz                  | numeric | -0.01351363  | 0.03101571         | the standard deviation of the body jerk acceleration time samples by "z" axis             |
| 21 | tbodygyromeanx                    | numeric | -0.002826419 | 0.192704476        | the mean gyroscope measurement time samples by "x" axis                                   |
| 22 | tbodygyromeany                    | numeric | -0.00247162  | 0.027470756        | the mean gyroscope measurement time samples by "y" axis                                   |
| 23 | tbodygyromeanz                    | numeric | -0.000233248 | 0.179102058        | the mean gyroscope measurement time samples by "z" axis                                   |
| 24 | tbodygyrostdx                     | numeric | -0.0264358   | 0.2676572          | the standard deviation of the gyroscope measurement time samples by "x" axis              |
| 25 | tbodygyrostdy                     | numeric | -0.01483926  | 0.476518714        | the standard deviation of the gyroscope measurement time samples by "y" axis              |
| 26 | tbodygyrostdz                     | numeric | -0.03140835  | 0.56487582         | the standard deviation of the gyroscope measurement time samples by "z" axis              |
| 27 | tbodygyrojerkmeanx                | numeric | -0.02209163  | -0.15721254        | the mean gyroscope measurement jerk time samples by "x" axis                              |
| 28 | tbodygyrojerkmeany                | numeric | -0.01320228  | -0.07680899        | the mean gyroscope measurement jerk time samples by "y" axis                              |
| 29 | tbodygyrojerkmeanz                | numeric | -0.006940664 | -0.092499853       | the mean gyroscope measurement jerk time samples by "z" axis                              |
| 30 | tbodygyrojerkstdx                 | numeric | -0.1639449   | 0.17914865         | the standard deviation of the gyroscope measurement jerk time samples by "x" axis         |
| 31 | tbodygyrojerkstdy                 | numeric | -0.01462992  | 0.29594593         | the standard deviation of the gyroscope measurement jerk time samples by "y" axis         |
| 32 | tbodygyrojerkstdz                 | numeric | -0.034421747 | 0.193206499        | the standard deviation of the gyroscope measurement jerk time samples by "z" axis         |
| 33 | tbodyaccmagmean                   | numeric | -0.000971395 | 0.644604325        | the mean magnetic body acceleration                                                       |
| 34 | tbodyaccmagstd                    | numeric | -0.01357712  | 0.42840592         | the standard deviation of the magnetic body acceleration                                  |
| 35 | tgravityaccmagmean                | numeric | -0.000971395 | 0.644604325        | the mean magnetic gravity acceleration                                                    |
| 36 | tgravityaccmagstd                 | numeric | -0.01357712  | 0.42840592         | the standard deviation of the magnetic gravity acceleration                               |
| 37 | tbodyaccjerkmagmean               | numeric | -0.017978463 | 0.434490401        | the mean body magnetic jerk acceleration                                                  |
| 38 | tbodyaccjerkmagstd                | numeric | -0.02028505  | 0.45061207         | the standard deviation of the body magnetic jerk acceleration                              |
| 39 | tbodygyromagmean                  | numeric | -0.003102438 | 0.418004609        | the mean body gyroscope jerk acceleration                                                 |
| 40 | tbodygyromagstd                   | numeric | -0.02184632  | 0.29997598         | the standard deviation of the body gyroscope jerk acceleration                             |
| 41 | tbodygyrojerkmagmean              | numeric | -0.04631178  | 0.08758166         | the mean body gyroscope magnetic jerk acceleration                                        |
| 42 | tbodygyrojerkmagstd               | numeric | -0.0438985   | 0.2501732          | the standard deviation of the body gyroscope magnetic jerk acceleration                    |
| 43 | fbodyaccmeanx                     | numeric | -0.02262392  | 0.53701202         | the mean acceleration of the body filtered samples by "x" axis                            |
| 44 | fbodyaccmeany                     | numeric | -0.006237    | 0.524187687        | the mean acceleration of the body filtered samples by "y" axis                            |
| 45 | fbodyaccmeanz                     | numeric | -0.04769426  | 0.28073595         | the mean acceleration of the body filtered samples by "z" axis                            |
| 46 | fbodyaccstdx                      | numeric | -0.004738197 | 0.658506543        | the standard deviation of the body acceleration filtered samples by "x" axis              |
| 47 | fbodyaccstdy                      | numeric | -0.002562942 | 0.560191344        | the standard deviation of the body acceleration filtered samples by "y" axis              |
| 48 | fbodyaccstdz                      | numeric | -0.03379653  | 0.68712416         | the standard deviation of the body acceleration filtered samples by "z" axis              |
| 49 | fbodyaccmeanfreqx                 | numeric | -1.06E-01    | 9.10E-02           | the mean gravity acceleration filtered samples by "x" axis                                |
| 50 | fbodyaccmeanfreqy                 | numeric | -0.002040511 | 0.466528232        | the mean gravity acceleration filtered samples by "y" axis                                |
| 51 | fbodyaccmeanfreqz                 | numeric | -0.002251953 | 0.402532553        | the mean gravity acceleration filtered samples by "z" axis                                |
| 52 | fbodyaccjerkmeanx                 | numeric | -0.007014723 | 0.474317256        | the standard deviation of the gravity acceleration filtered samples by "x" axis           |
| 53 | fbodyaccjerkmeany                 | numeric | -0.003091553 | 0.276716853        | the standard deviation of the gravity acceleration filtered samples by "y" axis           |
| 54 | fbodyaccjerkmeanz                 | numeric | -0.02487898  | 0.15777569         | the standard deviation of the gravity acceleration filtered samples by "z" axis           |
| 55 | fbodyaccjerkstdx                  | numeric | -0.004262891 | 0.476803887        | the mean jerk acceleration of the body filtered samples by "x" axis                       |
| 56 | fbodyaccjerkstdy                  | numeric | -0.00175392  | 0.349771285        | the mean jerk acceleration of the body filtered samples by "y" axis                       |
| 57 | fbodyaccjerkstdz                  | numeric | -0.006236475 | -0.99310776        | the mean jerk acceleration of the body filtered samples by "z" axis                       |
| 58 | fbodyaccjerkmeanfreqx             | numeric | -0.02350415  | 0.33144928         | the standard deviation of the body jerk acceleration filtered samples by "x" axis         |
| 59 | fbodyaccjerkmeanfreqy             | numeric | -1.06E-02    | 9.87E-02           | the standard deviation of the body jerk acceleration filtered samples by "y" axis         |
| 60 | fbodyaccjerkmeanfreqz             | numeric | -0.003916088 | 0.230107946        | the standard deviation of the body jerk acceleration filtered samples by "z" axis         |
| 61 | fbodygyromeanx                    | numeric | -0.029997    | 0.47496245         | the mean gyroscope measurement filtered samples by "x" axis                               |
| 62 | fbodygyromeany                    | numeric | -0.05570225  | 0.32881701         | the mean gyroscope measurement filtered samples by "y" axis                               |
| 63 | fbodygyromeanz                    | numeric | -0.01050471  | 0.49241438         | the mean gyroscope measurement filtered samples by "z" axis                               |
| 64 | fbodygyrostdx                     | numeric | -0.1083888   | 0.1966133          | the standard deviation of the gyroscope measurement filtered samples by "x" axis          |
| 65 | fbodygyrostdy                     | numeric | -0.02848957  | 0.64623364         | the standard deviation of the gyroscope measurement filtered samples by "y" axis          |
| 66 | fbodygyrostdz                     | numeric | -0.08225211  | 0.52245422         | the standard deviation of the gyroscope measurement filtered samples by "z" axis          |
| 67 | fbodygyromeanfreqx                | numeric | -0.003546796 | 0.249209412        | the mean gyroscope measurement jerk filtered samples by "x" axis                          |
| 68 | fbodygyromeanfreqy                | numeric | -0.003516971 | 0.273141323        | the mean gyroscope measurement jerk filtered samples by "y" axis                          |
| 69 | fbodygyromeanfreqz                | numeric | -0.005130402 | 0.377074097        | the mean gyroscope measurement jerk filtered samples by "z" axis                          |
| 70 | fbodyaccmagmean                   | numeric | -0.003533418 | 0.586637551        | the standard deviation of the gyroscope measurement jerk filtered samples by "x" axis     |
| 71 | fbodyaccmagstd                    | numeric | -0.021478788 | 0.178684581        | the standard deviation of the gyroscope measurement jerk filtered samples by "y" axis     |
| 72 | fbodyaccmagmeanfreq               | numeric | -0.000332754 | 0.435846932        | the standard deviation of the gyroscope measurement jerk filtered samples by "z" axis     |
| 73 | fbodybodyaccjerkmagmean           | numeric | -0.012882383 | 0.538404846        | the mean magnetic body acceleration                                                       |
| 74 | fbodybodyaccjerkmagstd            | numeric | -0.01395391  | 0.31634642         | the standard deviation of the magnetic body acceleration                                  |
| 75 | fbodybodyaccjerkmagmeanfreq       | numeric | -0.000259638 | 0.4880885          | the mean magnetic gravity acceleration                                                    |
| 76 | fbodybodygyromagmean              | numeric | -0.00036273  | 0.203979765        | the standard deviation of the magnetic gravity acceleration                               |
| 77 | fbodybodygyromagstd               | numeric | -0.06147658  | 0.23665966         | the mean body magnetic jerk acceleration                                                  |
| 78 | fbodybodygyromagmeanfreq          | numeric | -0.000262187 | 0.409521612        | the standard deviation of the body magnetic jerk acceleration                              |
| 79 | fbodybodygyrojerkmagmean          | numeric | -0.02290453  | 0.14661857         | the mean body gyroscope jerk acceleration                                                 |
| 80 | fbodybodygyrojerkmagstd           | numeric | -0.03985738  | 0.28783462         | the standard deviation of the body gyroscope jerk acceleration                             |
| 81 | fbodybodygyrojerkmagmeanfreq      | numeric | -0.000234019 | 0.42630168         | the mean body gyroscope magnetic jerk acceleration                                        |
| 82 | angletbodyaccmeangravity          | numeric | -1.06E-02    | 9.92E-03           | the standard deviation of the body gyroscope magnetic jerk acceleration                    |
| 83 | angletbodyaccjerkmeangravitymean  | numeric | -0.00016016  | 0.203259966        | the mean gravity acceleration time samples by "z" axis                                    |
| 84 | angletbodygyromeangravitymean     | numeric | -0.00086743  | 0.444101172        | the standard deviation of the gravity acceleration time samples by "x" axis               |
| 85 | angletbodygyrojerkmeangravitymean | numeric | -1.00E-01    | 9.91E-02           | the standard deviation of the gravity acceleration time samples by "y" axis               |
| 86 | anglexgravitymean                 | numeric | -0.3045485   | 0.7377844          | the standard deviation of the gravity acceleration time samples by "z" axis               |
| 87 | angleygravitymean                 | numeric | -1.76E-01    | 9.82E-02           | the mean acceleration of the body time samples by "x" axis                                |
| 88 | anglezgravitymean                 | numeric | -0.000327699 | 0.390444369        | the mean acceleration of the body time samples by "y" axis                                |