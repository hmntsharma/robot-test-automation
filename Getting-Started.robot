*** Settings ***
Documentation       IGP Transport Verification
Library		        SSHLibrary
Resource		    resource.robot
Suite Setup	        Open Connection And Log In
Suite Teardown	    Close all Connections

*** Variables ***
&{HOSTS}           pe1=pe1
...                p2=p2
...                p3=p3
...                p4=p4
...                pe5=pe5
...                p6=p6
...                p7=p7
...                p8=p8
...                p9=p9
${USERNAME}        cisco
${PASSWORD}        cisco

*** Keywords ***
Open Connection And Log In
        FOR     ${KEY}    ${HOST}    IN    &{HOSTS}
            IF    "${HOST}" == "pe1" or "${HOST}" == "p2" or "${HOST}" == "p3" or "${HOST}" == "p7" or "${HOST}" == "p4" 
                Open Connection		${HOST}        alias=${HOST}
                Login			    ${USERNAME}	${PASSWORD}
            END
        END

*** Test Cases ***
Test Suite
    Switch Connection  pe1
    PE1 - IPv4 Address Configuration
    PE1 - Ping to P2
    PE1 - ISIS Adjacency
    PE1 - Full Routing Table 
    PE1 - ISIS Route to PE5
    PE1 - Route to PE5
    PE1 - LDP Neighbor
    PE1 - MPLS Forwarding
    PE1 - CEF
    PE1 - Traceroute MPLS to PE5
    PE1 - MPLS Label Forwarding
    Switch Connection  p2
    P2 - MPLS Label Forwarding
    Switch Connection  p3
    P3 - MPLS Label Forwarding
    Switch Connection  p7
    P7 - MPLS Label Forwarding
    Switch Connection  p4
    P4 - MPLS Label Forwarding
