1. **Select *one* UDP packet from your trace. From this packet, determine how many fields there are in the UDP header. (You shouldn’t look in the textbook! Answer these questions directly from what you observe in the packet trace.) Name these fields.**

   - Src Port: 56570

   - Dst Port: 32412

   - Length: 29

   - Checksum: 0x4711

     <img src="/Users/test/Repo/Learning/Computer-Network/Computer Networking: A Top-Down Approach/wireshark-labs/udp/solution.assets/image-20220516212832782.png" alt="image-20220516212832782" style="zoom:50%;" />

2. **By consulting the displayed information in Wireshark’s packet content field for this packet, determine the length (in bytes) of each of the UDP header fields.**

   - Data is 21 bytes, so the whole length of header is 8 bytes
   - 2 bytes for each field

3. **The value in the Length field is the length of what? (You can consult the text for this answer). Verify your claim with your captured UDP packet.**

   - Length of the whole udp segment (header + data)

4. **What is the maximum number of bytes that can be included in a UDP payload? (Hint: the answer to this question can be determined by your answer to 2. above)**

   - Total length of udp segment in bytes is `2^16 - 1`, which equal to max data size + header
   - So max data size is `2^16 - 1 - 8`, in bytes

5. **What is the largest possible source port number? (Hint: see the hint in 4.)**

   - 65535 (2^16 - 1)

6. **What is the protocol number for UDP? Give your answer in both hexadecimal and decimal notation. To answer this question, you’ll need to look into the Protocol field of the IP datagram containing this UDP segment (see Figure 4.13 in the text, and the discussion of IP header fields).**

   - 17 in decimal and 0x11 in hexadecimal

     <img src="/Users/test/Repo/Learning/Computer-Network/Computer Networking: A Top-Down Approach/wireshark-labs/udp/solution.assets/image-20220516213517134.png" alt="image-20220516213517134" style="zoom:50%;" />

7. **Examine a pair of UDP packets in which your host sends the first UDP packet and the second UDP packet is a reply to this first UDP packet. (Hint: for a second packet to be sent in response to a first packet, the sender of the first packet should be the destination of the second packet). Describe the relationship between the port numbers in the two packets.**

   - The source port of the UDP packet sent by the host is the same as the destination port of the reply packet, and conversely the destination port of the UDP packet sent by the host is the same as the source port of the reply packet.

     ![image-20220516213737042](/Users/test/Repo/Learning/Computer-Network/Computer Networking: A Top-Down Approach/wireshark-labs/udp/solution.assets/image-20220516213737042.png)

     ![image-20220516213808770](/Users/test/Repo/Learning/Computer-Network/Computer Networking: A Top-Down Approach/wireshark-labs/udp/solution.assets/image-20220516213808770.png)