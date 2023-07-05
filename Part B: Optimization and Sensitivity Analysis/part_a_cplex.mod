/*********************************************
 * OPL 22.1.1.0 Model
 * Author: yakup
 * Creation Date: 20 May 2023 at 10:27:25
 *********************************************/
 int L = ...;
 int H = ...;
 int p = ...;
 
 range i = 1..10;
 range j = 1..3;
 range k = 1..20;
 range m = 1..8;
 range t = 1..6;
 
 int et[t,k] =...;
 int R[i] = ...;
 int G[j] = ...;
 int S[t] = ...;
 int ub[t,i] = ...;
 int lb[t,i] = ...;
 int d[i,j] = ...;
 int a[i,m] = ...;
 
 // Decision Variables
 dvar boolean x[i,m];
 dvar boolean e[k,i];
 dvar boolean b[i];
 dvar boolean y[k];
 dvar float o[i,k];
 dvar boolean w[i];
 
 //Model 
 maximize (sum(i in i,j in j)(d[i][j]*b[i]*G[j])-sum(i in i)(p*(1-b[i]))-sum(t in t, i in i, k in k)(e[k][i]*S[t]*et[t][k])-sum(k in k, i in i)(o[i][k]*50));
 subject to{
 	forall(k in k) {sum(i in i)e[k][i] >= 1;
 		sum(i in i)e[k][i]<=5;}
 	forall(i in i, t in t){(sum(k in k)e[k][i]*et[t][k])<=ub[t][i];
 		sum(k in k)(e[k][i]*et[t][k])>=lb[t][i];}
 	forall(m in m){sum(i in i)x[i][m]>=1;}
 	forall(i in i)sum(m in m)x[i][m]<=1;
 		sum(i in i)x[i][1]-sum(i in i)x[i][2]<=L;
 		sum(i in i)x[i][2]-sum(i in i)x[i][1]<=L;
 	forall(k in k){y[k]*8*30+sum(i in i)o[i][k]<= H;
 				   y[k]<=sum(i in i)e[k][i];
 				   10*y[k]>=sum(i in i)e[k][i];}
 	forall(k in k, i in i) o[i][k]<=H*e[k][i];
 	forall(i in i)sum(m in m)x[i][m]>=b[i];
 	forall(i in i, m in m)x[i][m]<=a[i][m];
 	//DİKKAT BURAYA
 	forall(i in i)((sum(k in k)(e[k][i]*8*30+o[i][k]*d[i][3])))>=R[i]*b[i];
 	x[1][1]>=w[1];
 	x[2][1]>=w[1];
 	x[1][1]+x[2][1]-1<=w[1];
 	1-w[1]<=x[3][3];
 	forall(i in i) (1-b[i])*d[i][2]<=w[2];
 	forall(i in i) 1-w[2]>=(1-b[i])*d[i][3];
 	forall(i in i, k in k)o[i][k]>=0;
}