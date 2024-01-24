# 3CX GUI Configuration

## 1. Add Single Extension

1. Select <code>Users</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-1.png" alt="">

2. Select <code>+ Add</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-2.png" alt="">

3. Fill in Extension Information

**Extension:** Extension Number

**First Name:** User's First Name

**Last Name:** User's Last Name

**Email Address:** User's Email (optional)

**Mobile Number:** User's Cell (optional)

**Outbound Caller ID:** Caller ID for outbound calls

If no caller ID is set then it will default to the trunk's caller ID.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-3.png" alt="">

---

## 2. Add Call Queues

With 3CX you can create call queues or ring groups and handle incoming calls as a team:

- **Call Queues** - queue calls for when agents are available. If all agents are busy, calls are kept waiting until one becomes available.
Call queues are used to manage incoming calls efficiently by routing them to a group of agents or extensions.



1. Select <code>Call Queues</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-4.png" alt="">

2. Select <code>+ Add</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-5.png" alt="">

---

### 2.a. For Sales Team

Configure Call Queue settings

- **Name:** Sales
- **Extension:** 801
- **Polling Strategy:** Round Robin
- **Ring Time (Seconds):** 30
- **Maximum Queue Wait Time (seconds):** 1800 (End Call)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-6.png" alt="">

- Select the <code>Agents</code> tab and click on the <code>+ Add</code> button.
- Select your queue agent(s).
- Click on <code>OK</code> to create the Call Queue:
---

### 2.b. For Support Team

Configure Call Queue settings

- **Name:** support
- **Extension:** 802
- **Polling Strategy:** Round Robin
- **Ring Time (Seconds):** 30
- **Maximum Queue Wait Time (seconds):** 1800 (End Call)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-7.png" alt="">

- Select the <code>Agents</code> tab and click on the <code>+ Add</code> button.
- Select your queue agent(s).
- Click on <code>OK</code> to create the Call Queue:
---

### 3.c. For Others Team

Configure Call Queue settings

- **Name:** Others
- **Extension:** 801
- **Polling Strategy:** Round Robin
- **Ring Time (Seconds):** 30
- **Maximum Queue Wait Time (seconds):** 1800 (End Call)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-8.png" alt="">

- Select the <code>Agents</code> tab and click on the <code>+ Add</code> button.
- Select your queue agent(s).
- Click on <code>OK</code> to create the Call Queue:
---



## 3. SIP Trunk Setup


1. Select <code>SIP Trunks</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-9.png" alt="">

2. Select <code>+ Add SIP Trunks</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-10.png" alt="">


### 3.a Callcentric SIP

Add SIP Trunk/VoIP Provider

- **Select Country:** US

- **Select Provider in your Country:** Callcentric

- **Main Trunk No:** 16503604607

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-11.png" alt="">

Fill in Authentication with the information provided by Callcentric

- **Enter name for Trunk:** Callcentric

- **Registrar/Server/Gateway Hostname or IP:** sip.callcentric.net

- **Outbound Proxy:** sip.callcentric.net

- **Number of SIM Calls:** 3

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-12.png" alt="">

- **Type of Authentication:** Register/Account Based

- **Authentication ID (aka SIP User ID):** 17778761681

- **Authentication Password:** Provided by Callcentric

- **Main Trunk No:** 16503604607

- **Destination for calls during office hours:** Extension (IVR 800 welcome ivr)

- **Destination for calls outside office hours:** End Call

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-13.png" alt="">

Click on the <code>DIDs</code> tab at the top, then select <code>+ ADD Single DID</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-14.png" alt="">

Enter the DID number and click off the number box or select <code>+ ADD Single DID</code> to add another number.

- By default, Callcentric formats the number in 10 digits, but can support +1 or any prefix. Set up the prefix in our Portal.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-15.png" alt="">

---

### 3.b Airtel SIP Trunks

Add SIP Trunk/VoIP Provider

- **Select Country:** Generic

- **Select Provider in your Country:** Generic SIP Trunk

- **Main Trunk No:** 8047292860

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-16.png" alt="">

Fill in Authentication with the information provided by Callcentric

- **Enter name for Trunk:** Airtel SIP Trunk

- **Registrar/Server/Gateway Hostname or IP:** ka.ims.airtel.in

- **Outbound Proxy:** 10.5.70.3

- **Number of SIM Calls:** 10

- **Type of Authentication:** Register/Account Based

- **Authentication ID (aka SIP User ID):** +918047292860

- **Authentication Password:** Provided by Airtel

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-17.png" alt="">

- **Main Trunk No:** +918047292860

- **Destination for calls during office hours:** Extension (IVR 800 welcome ivr)

- **Destination for calls outside office hours:** End Call

Click on the <code>DIDs</code> tab at the top, then select <code>+ ADD Single DID</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-19.png" alt="">

Enter the DID number and click off the number box or select <code>+ ADD Single DID</code> to add another number.

- By default, Airtel formats the number in 10 digits, but can support +91 or any prefix. Set up the prefix in our Portal.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-20.png" alt="">


## 4. Inbound Rules

1. Select <code>Inbound Rules</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-21.png" alt="">

#### Configure DID Rules

2. Select <code>+ Add DID Rule</code>

DID rules control how your incoming calls route.

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-22.png" alt="">


### 4.a. For Airtel SIP 

Configure DID rule

- **Name:** Airtel Inbound

- **DID:** +91804729860

Select your routing for both during and out of office hours.

- **Destination for calls during office hours:** Extension (IVR 800 welcome ivr)

- **Destination for calls outside office hours:** Extension (IVR 800 welcome ivr)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-23.png" alt="">


---

### 4.b. For Callcentric SIP 

Configure DID rule

- **Name:** Callcentric Inbound

- **DID:** 16503604607 

Select your routing for both during and out of office hours.

- **Destination for calls during office hours:** Extension (IVR 800 welcome ivr)

- **Destination for calls outside office hours:** Extension (IVR 800 welcome ivr)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-24.png" alt="">


### 4.c. For Bhanu Extension 

Configure DID rule

- **Name:** Bhanu Inbound

- **DID:** *2861

Select your routing for both during and out of office hours.

- **Destination for calls during office hours:** Extension (101 Bhanu Pratap Singh Slathia)

- **Destination for calls outside office hours:** Extension (101 Bhanu Pratap Singh Slathia)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-25.png" alt="">

### 4.d. For Mahima Extension 

Configure DID rule

- **Name:** Mahima Inbound

- **DID:** *2861

Select your routing for both during and out of office hours.

- **Destination for calls during office hours:** Extension (109 Mahima Bali)

- **Destination for calls outside office hours:** Extension (109 Mahima Bali)

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-26.png" alt="">

--- 


## 5. Outbound Rules

1. Select <code>Outbound Rules</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-27.png" alt="">

2. Select <code>+ Add</code>

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-28.png" alt="">

## 5.a. For Callcentric SIP

Configure Outbound

- **Rule Name:** Callcentric SIP

- **Calls to numbers starting with prefix:**

- **Calls from extension(s):** 000-999

- **Calls to Numbers with a length of:** 0-15

- **Route:** Callcentric

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-29.png" alt="">

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-30.png" alt="">

---

## 5.b. For Airtel SIP

Configure Outbound

- **Rule Name:** Airtel SIP

- **Calls to numbers starting with prefix:** 91

- **Calls from extension(s):** 000-999

- **Calls to Numbers with a length of:** 0-15

- **Route:** Callcentric 

- **Strip Digits:** 2

- **Prepend:** 0

<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-31.png" alt="">


<img src="https://raw.githubusercontent.com/ladybirdweb/faveo-server-images/master/_docs/installation/providers/enterprise/3cx-images/3cx-gui-32.png" alt="">