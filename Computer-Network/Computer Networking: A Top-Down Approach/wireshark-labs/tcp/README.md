1. **What is the IP address and TCP port number used by the client computer (source) that is transferring the file to gaia.cs.umass.edu? To answer this question, it’s probably easiest to select an HTTP message and explore the details of the TCP packet used to carry this HTTP message, using the “details of the selected packet header window” (refer to Figure 2 in the “Getting Started with Wireshark” Lab if you’re uncertain about the Wireshark windows.**

   - The IP address and TCP port number used by the client computer is **192.168.1.102:1161**

2. **What is the IP address of gaia.cs.umass.edu? On what port number is it sending and receiving TCP segments for this connection?**

   - IP of gaia.cs.umass.edu is **128.119.245.12**
   - Port is **80**

3. **What is the IP address and TCP port number used by your client computer (source) to transfer the file to gaia.cs.umass.edu?**

   - 192.168.50.78:64608

4. **What is the sequence number of the TCP SYN segment that is used to initiate the TCP connection between the client computer and gaia.cs.umass.edu? What is it in the segment that identifies the segment as a SYN segment?**

   - Sequence Number (raw): 232129012
   - Flags: 0x002(SYN)

5. **What is the sequence number of the SYNACK segment sent by gaia.cs.umass.edu to the client computer in reply to the SYN? What is the value of the Acknowledgement field in the SYNACK segment? How did gaia.cs.umass.edu determine that value? What is it in the segment that identifies the segment as a SYNACK segment?**

   - Sequence Number (raw): 883061785
   - Acknowledgment number (raw): 232129013, equal to client's Seq + 1
   - Flags: 0x012(SYN, ACK)

6. **What is the sequence number of the TCP segment containing the HTTP POST command? Note that in order to find the POST command, you’ll need to dig into the packet content field at the bottom of the Wireshark window, looking for a segment with a “POST” within its DATA field.**

   - Sequence Number (raw): 232129013
   - It's the first segment after the three-way handshake (not the last segment of three-way handshake)

7. **Consider the TCP segment containing the HTTP POST as the first segment in the TCP connection. What are the sequence numbers of the first six segments in the TCP connection (including the segment containing the HTTP POST)? At what time was each segment sent? When was the ACK for each segment received? Given the difference between when each TCP segment was sent, and when its acknowledgement was received, what is the RTT value for each of the six segments? What is the `EstimatedRTT` value (see Section 3.5.3, page 242 in text) after the receipt of each ACK? Assume that the value of the `EstimatedRTT` is equal to the measured RTT for the first segment, and then is computed using the EstimatedRTT equation on page 242 for all subsequent segments.**

   - First 6 segments' sequence numbers
     - 232129013, 232129578, 232131038, 232132498, 232133958, 232135418
   - Time of sent and recv
     - 2004-08-21 21:44:20.596858/.624318
     - .612118/.647675
     - .624407/.694466
     - .625071/.739499
     - .647786/.787680
     - .648538/.838183
   - Difference in ms, they are just the RTT
     - 27.46
     - 35.56
     - 70.06
     - 114.43
     - 139.90
     - 189.64
   - EstimatedRTT
     - 27.46
     - 28.4725
     - 32.785
     - 38.33125
     - 41.515
     - 47.7325

8. **What is the length of each of the first six TCP segments?**

   - 565, 1460, 1460, 1460, 1460, 1460

9. **What is the minimum amount of available buffer space advertised at the received for the entire trace? Does the lack of receiver buffer space ever throttle the sender?**

   - 5840 (in the first ACK from receiver)
   - No

10. **Are there any retransmitted segments in the trace file? What did you check for (in the trace) in order to answer this question?**

    - By checking if there are any segments the client sent with same seq number
      - In the *Stevens* view of wireshark, the seq number grows monotonically with respect to time, means no segment with same seq number was transmitted

11. **How much data does the receiver typically acknowledge in an ACK? Can you identify cases where the receiver is ACKing every other received segment (see Table 3.2 on page 250 in the text).**

    - Mostly 1460
    - If the length of data acked by receiver is greater than 1460, then it's acking every other received segment

12. **What is the throughput (bytes transferred per unit time) for the TCP connection? Explain how you calculated this value.**

    - `164091 Bytes / 5.651141 s = 28.35644531 kBps`

    - 164091 is the amount that receiver has acknowledged

    - 5.651141s is the total time between the first segment's sent and last segment's received

      > The result is different from [the solution](http://mfatihas.it.student.pens.ac.id/Wireshark_TCP.pdf), because we calculate the total time in the different way.