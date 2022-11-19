#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
int length_cpp(NumericVector x) {
  return x.size();
}

// [[Rcpp::export]]
float mean_cpp(NumericVector x) {
  double n = length_cpp(x);

  double sum = 0.0;

  for (int i = 0; i < n; i++) {
    sum += x[i];
  }

  double mean = sum/n;

  return mean;
}

// [[Rcpp::export]]
float sd_cpp(NumericVector x) {
  double n = length_cpp(x);

  double mean = mean_cpp(x);

  double sum = 0.0;

  NumericVector diff;

  //for (int i = 0; i < n; i++) {
  //  x[i] = x[i] - mean;
  //  sum += x[i]*x[i];
  //}

  diff = (x-mean) * (x-mean);

  for (int i = 0; i < n; i++) {
    sum += diff[i];
  }

  double sd = sqrt(sum/(n-1));
  return sd;
}
