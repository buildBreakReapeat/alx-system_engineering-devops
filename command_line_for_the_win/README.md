## SFTP Diagrams

SFTP	(Secure File Transfer Protocol) It is a network protocol that provides a secure way to transfer files between a client and a server over a network. SFTP is designed to be a more secure alternative to the traditional FTP (File Transfer Protocol) by using encryption and authentication mechanisms.

```mermaid
sequenceDiagram
Local Machine ->> SFTP: Fetches files from local using put
SFTP-->>Remote: Transferred to Remote

