*** Keywords ***
PE1 - IPv4 Address Configuration
    [Documentation]      IPv4 Address Configuration
	${OUTPUT}            Execute Command        show ipv4 interface brief
	Should Contain       ${OUTPUT}              12.0.0.1

PE1 - Ping to P2
	[Documentation]	     Ping to P2
	${OUTPUT}            Execute Command		ping 12.0.0.2 source 12.0.0.1
    Should Contain		 ${OUTPUT}		        100 percent

PE1 - ISIS Adjacency
	[Documentation]	     ISIS Adjacency
	${OUTPUT}            Execute Command		show isis adjacency
    Should Contain		 ${OUTPUT}		        P2

PE1 - Full Routing Table 
	[Documentation]	     Full Routing Table 
	${OUTPUT}            Execute Command		show route
    Should Contain		 ${OUTPUT}		        2.2.2.2
    Should Contain		 ${OUTPUT}		        3.3.3.3
    Should Contain		 ${OUTPUT}		        4.4.4.4
    Should Contain		 ${OUTPUT}		        5.5.5.5
    Should Contain		 ${OUTPUT}		        6.6.6.6
    Should Contain		 ${OUTPUT}		        7.7.7.7
    Should Contain		 ${OUTPUT}		        8.8.8.8

PE1 - ISIS Route to PE5
	[Documentation]	     ISIS Route to PE5
	${OUTPUT}            Execute Command		show isis route 5.5.5.5/32 detail
    Should Contain		${OUTPUT}		        PE5

PE1 - Route to PE5
	[Documentation]	     Route to PE5
	${OUTPUT}            Execute Command		show route 5.5.5.5/32 detail
    Should Contain		 ${OUTPUT}		        12.0.0.2

PE1 - LDP Neighbor
	[Documentation]	     LDP Neighbor
	${OUTPUT}            Execute Command		show mpls ldp neighbor brief
    Should Contain		 ${OUTPUT}		        2.2.2.2

PE1 - MPLS Forwarding
	[Documentation]	     MPLS Forwarding
	${OUTPUT}            Execute Command		show mpls forwarding
    Should Contain		 ${OUTPUT}		        2.2.2.2
    Should Contain		 ${OUTPUT}		        3.3.3.3
    Should Contain		 ${OUTPUT}		        4.4.4.4
    Should Contain		 ${OUTPUT}		        5.5.5.5
    Should Contain		 ${OUTPUT}		        6.6.6.6
    Should Contain		 ${OUTPUT}		        7.7.7.7
    Should Contain		 ${OUTPUT}		        8.8.8.8
    Should Not Contain   ${OUTPUT}		        unlabel         ignore_case=True

PE1 - CEF
	[Documentation]	     CEF
	${OUTPUT}            Execute Command        show cef 5.5.5.5/32
    Should Match Regexp  ${OUTPUT}	            local label \\d+
    Should Match Regexp  ${OUTPUT}              labels imposed {\\d+}

PE1 - Traceroute MPLS to PE5
	[Documentation]      Traceroute MPLS to PE5
	${OUTPUT}            Execute Command        traceroute mpls multipath ipv4 5.5.5.5/32 verbose
    Should Contain       ${OUTPUT}              Path 0 found
    Should Contain       ${OUTPUT}              Path 1 found
    Should Contain       ${OUTPUT}              34.0.0.4 45.0.0.5
    Should Contain       ${OUTPUT}              47.0.0.4 45.0.0.5
    Should Contain       ${OUTPUT}              45.0.0.5, ret code 3 multipaths 0

PE1 - MPLS Label Forwarding
    [Documentation]      MPLS Label Forwarding to PE5
	${OUTPUT}            Execute Command        show mpls forwarding prefix 5.5.5.5/32
	Should Contain       ${OUTPUT}              Gi0/0/0/2    12.0.0.2

P2 - MPLS Label Forwarding
    [Documentation]      MPLS Label Forwarding to PE5
	${OUTPUT}            Execute Command        show mpls forwarding prefix 5.5.5.5/32
	Should Contain       ${OUTPUT}              Gi0/0/0/0    23.0.0.3
	Should Contain       ${OUTPUT}              Gi0/0/0/3    27.0.0.7

P3 - MPLS Label Forwarding
    [Documentation]      MPLS Label Forwarding to PE5
	${OUTPUT}            Execute Command        show mpls forwarding prefix 5.5.5.5/32
	Should Contain       ${OUTPUT}              Gi0/0/0/2    34.0.0.4

P7 - MPLS Label Forwarding
    [Documentation]      MPLS Label Forwarding to PE5
	${OUTPUT}            Execute Command        show mpls forwarding prefix 5.5.5.5/32
	Should Contain       ${OUTPUT}              Gi0/0/0/4    47.0.0.4

P4 - MPLS Label Forwarding
    [Documentation]      MPLS Label Forwarding to PE5
	${OUTPUT}            Execute Command        show mpls forwarding prefix 5.5.5.5/32
	Should Contain       ${OUTPUT}              Gi0/0/0/0    45.0.0.5
