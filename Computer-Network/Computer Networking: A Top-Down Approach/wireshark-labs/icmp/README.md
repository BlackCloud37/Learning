1. **What is the IP address of your host? What is the IP address of the destination host?**

   - 192.168.1.101

   - 143.89.14.34

     <img src="README.assets/image-20220522150208579.png" alt="image-20220522150208579" style="zoom:50%;" />

2. **Why is it that an ICMP packet does not have source and destination port numbers?**

   - Because it's a  network-layer protocol and not port number is needed

3. **Examine one of the ping request packets sent by your host. What are the ICMP type and code numbers? What other fields does this ICMP packet have? How many bytes are the checksum, sequence number and identifier fields?**

   - Echo request(8), code 0
   - Checksum, Identifier, Sequence Number, Data

4. **Examine the corresponding ping reply packet. What are the ICMP type and code numbers? What other fields does this ICMP packet have? How many bytes are the checksum, sequence number and identifier fields?**

   - Echo reply(0), code 0
   - Checksum, Identifier, Sequence Number, Data
   - Checksum, sequence number and identifier fields are two bytes each

5. **What is the IP address of your host? What is the IP address of the target destination host?**

   - 192.168.1.101
   - 138.96.146.2

6. **If ICMP sent UDP packets instead (as in Unix/Linux), would the IP protocol number still be 01 for the probe packets? If not, what would it be?**

   - No
   - 0x11

7. **Examine the ICMP echo packet in your screenshot. Is this different from the ICMP ping query packets in the first half of this lab? If yes, how so?**

   - No, they are the same

8. **Examine the ICMP error packet in your screenshot. It has more fields than the ICMP echo packet. What is included in those fields?**

   - It contains both the IP header and the first 8 bytes of the original ICMP packet that the error is for

9. **Examine the last three ICMP packets received by the source host. How are these packets different from the ICMP error packets? Why are they different?**

   - Their Type is Echo reply rather than Time-to-live exceeded
   - Because the TTL is big enough so the ICMP packet can reach the dest host