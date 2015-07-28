<h1>Install Intsructions</h1>
<h2>pitemp</h2>
<p>Open a terminal and paste:</p>
<code> wget -qO- https://raw.githubusercontent.com/zvakanaka/raspbian-scripts/master/pitemp.cpp | sudo g++ -o /usr/local/bin/pitemp -x c++ - </code>
<h2>Gmail Setup</h2>
<p>Open a terminal and paste:</p>
<code>wget https://raw.githubusercontent.com/zvakanaka/raspbian-scripts/master/setupGmail.sh && sudo bash setupGmail.sh; rm setupGmail.sh</code>
<h1>Usage</h1>
<h2>pitemp</h2>
<p>By default, <code><pitemp/code> with no parameters will display the CPU temperature of a Raspberry Pi in Fahrenheit.</p>
<h3>Converting</h3>
<p>Convert F to C: <code><pitemp -f 100/code></p>
<p>Convert C to F: <code><pitemp -c 32/code></p>
