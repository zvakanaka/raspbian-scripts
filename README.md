<h1>Install Intsructions</h1>
<h2>pitemp - Temperature Monitor for the RPi</h2>
<p>Open a terminal and paste:</p>
<code> wget -qO- https://raw.githubusercontent.com/zvakanaka/raspbian-scripts/master/pitemp.cpp | sudo g++ -o /usr/local/bin/pitemp -x c++ - </code>
<h2>Gmail Setup - Ssmtp Setup for Debian/Ubuntu</h2>
<p>Open a terminal and paste:</p>
<code>wget https://raw.githubusercontent.com/zvakanaka/raspbian-scripts/master/setupGmail.sh && sudo bash setupGmail.sh; rm setupGmail.sh</code>
<h1>Usage</h1>
<h2>pitemp</h2>
<p>By default, <code>pitemp</code> with no parameters will display the CPU temperature of a Raspberry Pi in Fahrenheit.</p>
<h3>Options</h3>
<p>Convert F to C: </p><code>pitemp -f 100</code>
<p>Convert C to F: </p><code>pitemp -c 32</code>
