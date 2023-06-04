# Source-based arbitrary file overwrite vulnerability
Source code verifiers are one of the critical components in the blockchain system. There exist many applications that rely on their service, e.g., vulnerability scanner. When source code verification results are faulty, downstream applications that depend on them are also affected.

## Methodology & Overview
We have conducted a survey on downstream applications, especially for those that require source code and is able to access Ethereum browsers. 
Consequently, we found that the security impact resulted from source code verifiers on downstream applications far exceeds our expectations. Not only the usability of these applications would be affected, but also the hosting environment of these applications would be attacked. Specifically, we discovered an arbitrary file overwriting vulnerability in Slither and Echidna, a well-known vulnerability detector. We have reported this issue to their official team, and they confirmed after one day.

## Case Study: Slither Arbitrary File Overwriting
When Slither performs vulnerability detection on the given smart contract, the corresponding source code will be downloaded from Etherscan to the local environment. To enable the vulnerability detection on DApps composed of multiple smart contracts, in the local environment, these source code files will be organized according to the paths declared in the configuration file.
Intuitively, Slither should pay more attention to prevent security issues, e.g., path traversal or arbitrary file overwriting. However, Slither's complete trust in the results provided by Etherscan leads to security problems.

provided by Etherscan is downloaded to the local device based on the crytic-compile library and the download path will follow the path in the source code results. This means that there should be sufficient input validation for the source code to prevent possible security issues such as path traversal. However, the lack of input validation in the crytic-compile allows us to write source files to arbitrary paths.

Based on the contract source code with the path traversal problem shown below, we can make it possible for Slither and Echidna to store source code files in arbitrary path when downloading verified source code for analysis.

Further, we can use the $\mathcal{A}_1$ series of attacks to preemptively verify other contract, prompting Slither to have a higher probability of obtaining the source code results with path traversal risk. In asciinema [The arbitrary file overwrite vulnerability in slither and echidna .](https://asciinema.org/a/dSOPyqvtgaHSZTTAOdMYCGhcY) we show the complete attack. Currently, we have reported this vulnerability to Trail of Bits and it has been fixed by [Trail of Bits's fix PR for path traversal vulnerability](https://github.com/crytic/crytic-compile/pull/425).Because of this vulnerability, we get a credit and a bugbounty from trail of bits!
```json
{
  "language": "Solidity",
  "sources": {
    "../../../../.env": {"content": ".."}
  },
  "settings": {
    ...
  }
}
```
