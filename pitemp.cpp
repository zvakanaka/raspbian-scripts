#include <iostream>
#include<stdlib.h>//atof
#include <fstream>
using namespace std;

/**********************************************************************
 * Temperature Converter between Celsius or Fahrenheit
 * Displays CPU temperature by default
 * Made for the Raspberry Pi by Adam Quinton
 * Options:
 *  pitemp [-c | -f] [temperature]
 ***********************************************************************/

/**********************************************************************
 * Celsius to Fahrenheit
 ***********************************************************************/
float c2f(float c)
{
  if (c >= -273.15)
    {
      float f = c*(9.0/5.0)+32;
      return f;
    }
  cerr << "ERROR: MINIMUM CELSIUS LIMIT";
}

/**********************************************************************
 * Fahrenheit to Celsius
 ***********************************************************************/
float f2c(float f)
{
  float c = (5.0/9.0)*(f-32);
  return c;
}

/**********************************************************************
 * Reads Celsius from system file and Converts to Fahrenheit
 ***********************************************************************/
float readTemp()
{
  string tempValue;
  ifstream fin;
  string infile = "/sys/class/thermal/thermal_zone0/temp";
  fin.open(infile.c_str());
  if (fin.fail())
    cerr << "FILE ERROR" << endl;
  getline(fin, tempValue);
  fin.close();
   
  return c2f(atof(tempValue.c_str())/1000);  
}

int main(int argc, char **argv)
{
  float result = 0;
   
  if (argc == 3 && argv[1][1] == 'f')
    result = f2c(atof(argv[2]));
  else if (argc == 3 && argv[1][1] == 'c')
    result = c2f(atof(argv[2]));
  else//read from file
    result = readTemp();

  //output result
  cout << result << endl;
   
  return 0;
}
