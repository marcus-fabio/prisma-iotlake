import { Prisma, PrismaClient } from ".prisma/client/iotlake";

const prismaClient = new PrismaClient();

async function upsertData() {
  await prismaClient
    .$connect()
    .then(() => console.log(`Connected on ${process.env.DEPLOY_STAGE}`));

  // Data that should be inserted in all environments
  await upsertNetworkTypes();
  await upsertNetworks();

  // Data that should be inserted in all environments except production
  if (process.env.NODE_ENV !== "production") {
    await upsertDeviceTypes();
    await upsertEquipments();
    await upsertDevices();
    await upsertServiceToken();
    await upsertActionTypes();
    await upsertTriggerTypes();
  }

  await prismaClient.$disconnect();
}

async function upsertActionTypes() {
  console.log("Seeding Action types...");

  // Just for dev, qa, test and local
  const actionTypes: Prisma.ActionTypeUncheckedCreateInput[] = [
    { id: "HTTP", name: "HTTP", description: "HTTP" },
    { id: "DATABASE", name: "Database", description: "Database" },
    { id: "SQS", name: "AWS SQS", description: "AWS SQS" },
    { id: "ANALYSIS", name: "Analysis", description: "Analysis" },
  ];

  for (const actionType of actionTypes) {
    await prismaClient.actionType.upsert({
      where: { id: actionType.id },
      update: actionType,
      create: actionType,
    });
  }
}

async function upsertTriggerTypes() {
  console.log("Seeding Trigger types...");

  // Just for dev, qa, test and local
  const triggerTypes: Prisma.TriggerTypeUncheckedCreateInput[] = [
    { id: "VARIABLE", name: "Variable", description: "Variable" },
    { id: "SCHEDULE", name: "Schedule", description: "Schedule" },
  ];

  for (const triggerType of triggerTypes) {
    await prismaClient.triggerType.upsert({
      where: { id: triggerType.id },
      update: triggerType,
      create: triggerType,
    });
  }
}

async function upsertNetworkTypes() {
  console.log("Seeding network types...");
  const networkTypes: Prisma.NetworkTypeUncheckedCreateInput[] = [
    { id: "NO_NET", description: "No Network" },
    { id: "SIGFOX", description: "Sig-fox" },
    { id: "TTN_V3", description: "TTN v3" },
    { id: "NBIOT", description: "NB IoT" },
    { id: "HTTP", description: "HTTP" },
    { id: "EVERYNET", description: "Everynet" },
    { id: "LORASERVER", description: "Lora Server" },
    { id: "CHIRPSTACK", description: "ChirpStack" },
    { id: "NETMORE", description: "Net More" },
  ];

  for (const networkType of networkTypes) {
    await prismaClient.networkType.upsert({
      where: { id: networkType.id },
      update: networkType,
      create: networkType,
    });
  }
}

async function upsertNetworks() {
  console.log("Seeding networks...");
  const networks: Prisma.NetworkUncheckedCreateInput[] = [
    {
      id: "NO_NET",
      name: "No Network",
      parserEnabled: false,
      networkTypeID: "NO_NET",
    },
    {
      id: "EVERYNET",
      name: "Enablers Broker Everynet",
      parserEnabled: false,
      networkTypeID: "EVERYNET",
    },
    {
      id: "SIGFOX",
      name: "SIGFOX Enablers Account",
      parserEnabled: false,
      networkTypeID: "SIGFOX",
    },
    {
      id: "NBIOT",
      name: "Enablers NBIOT Middleware",
      parserEnabled: false,
      networkTypeID: "NBIOT",
    },
    {
      id: "HTTP",
      name: "Enablers HTTPS Server",
      parserEnabled: false,
      networkTypeID: "HTTP",
    },
    {
      id: "TTN_V3",
      name: "TTN V3 Community",
      parserEnabled: false,
      networkTypeID: "TTN_V3",
    },
    {
      id: "CHIRPSTACK",
      name: "Enablers ChirpStack Server",
      parserEnabled: false,
      networkTypeID: "CHIRPSTACK",
    },
  ];

  for (const network of networks) {
    await prismaClient.network.upsert({
      where: { id: network.id },
      update: network,
      create: network,
    });
  }
}

async function upsertDeviceTypes() {
  // Just for dev, qa, test and local
  console.log("Seeding device types...");
  const deviceTypes: Prisma.DeviceTypeUncheckedCreateInput[] = [
    {
      id: "000000000000000000000000",
      name: "No Network Default Device Type",
      parserEnabled: false,
      networkID: "NO_NET",
    },
    {
      id: "000000000000000000000001",
      name: "Lora Everynet Default Device Type",
      parserEnabled: false,
      networkID: "EVERYNET",
    },
    {
      id: "000000000000000000000002",
      name: "SIGFOX Default Device Type",
      parserEnabled: false,
      networkID: "SIGFOX",
    },
    {
      id: "000000000000000000000003",
      name: "NBIOT Default Device Type",
      parserEnabled: false,
      networkID: "NBIOT",
    },
    {
      id: "000000000000000000000004",
      name: "HTTP Default Device Type",
      parserEnabled: false,
      networkID: "HTTP",
    },
    {
      id: "000000000000000000000005",
      name: "TTN V3 Default Device Type",
      parserEnabled: false,
      networkID: "TTN_V3",
    },
    {
      id: "000000000000000000000006",
      name: "ChirpStack Default Device Type",
      parserEnabled: false,
      networkID: "CHIRPSTACK",
    },
  ];

  for (const deviceType of deviceTypes) {
    await prismaClient.deviceType.upsert({
      where: { id: deviceType.id },
      update: deviceType,
      create: deviceType,
    });
  }
}

async function upsertEquipments() {
  // Just for dev, qa, test and local
  console.log("Seeding equipments...");
  const equipment: Prisma.EquipmentUncheckedCreateInput[] = [
    {
      id: "000000000000000000000000",
      name: "Test No Net Equipment",
      description: "Test No Net Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000001",
      name: "Test Lora Everynet Equipment",
      description: "Test Lora Everynet Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000002",
      name: "Test Sigfox Equipment",
      description: "Test Sigfox Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000003",
      name: "Test NBIoT Equipment",
      description: "Test NbIoT Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000004",
      name: "Test HTTP Equipment",
      description: "Test HTTP Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000005",
      name: "Test Lora TTN V3 Equipment",
      description: "Test Lora TTN V3 Equipment",
      applicationId: "0000000000000000",
    },
    {
      id: "000000000000000000000006",
      name: "Test Lora ChirpStack Equipment",
      description: "Test Lora ChirpStack Equipment",
      applicationId: "0000000000000000",
    },
  ];

  for (const equip of equipment) {
    await prismaClient.equipment.upsert({
      where: { id: equip.id },
      update: equip,
      create: equip,
    });
  }
}

async function upsertDevices() {
  // Just for dev, qa, test and local
  console.log("Seeding devices...");
  const devices: Prisma.DeviceUncheckedCreateInput[] = [
    {
      id: "000000000000000000000000",
      name: "Test No Net Device",
      parserEnabled: false,
      radioSerial: "0000000000000000",
      deviceTypeID: "000000000000000000000000",
      equipmentID: "000000000000000000000000",
    },
    {
      id: "000000000000000000000001",
      name: "Test Lora Everynet Device",
      parserEnabled: false,
      radioSerial: "0000000000000001",
      deviceTypeID: "000000000000000000000001",
      equipmentID: "000000000000000000000001",
    },
    {
      id: "000000000000000000000002",
      name: "Test SIGFOX Device",
      parserEnabled: false,
      radioSerial: "0000000000000002",
      deviceTypeID: "000000000000000000000002",
      equipmentID: "000000000000000000000002",
    },
    {
      id: "000000000000000000000003",
      name: "Test NBIOT Device",
      parserEnabled: false,
      radioSerial: "0000000000000003",
      deviceTypeID: "000000000000000000000003",
      equipmentID: "000000000000000000000003",
    },
    {
      id: "000000000000000000000004",
      name: "Test HTTP Device",
      parserEnabled: false,
      radioSerial: "0000000000000004",
      deviceTypeID: "000000000000000000000004",
      equipmentID: "000000000000000000000004",
    },
    {
      id: "000000000000000000000005",
      name: "Test Lora TTN V3 Device",
      parserEnabled: false,
      radioSerial: "0000000000000005",
      deviceTypeID: "000000000000000000000005",
      equipmentID: "000000000000000000000005",
    },
    {
      id: "000000000000000000000006",
      name: "Test Lora ChirpStack Device",
      parserEnabled: false,
      radioSerial: "0000000000000006",
      deviceTypeID: "000000000000000000000006",
      equipmentID: "000000000000000000000006",
    },
  ];

  for (const device of devices) {
    await prismaClient.device.upsert({
      where: { id: device.id },
      update: device,
      create: device,
    });
  }
}

async function upsertServiceToken() {
  // Just for dev, qa, test and local
  console.log("Seeding service token...");
  const currentDate = new Date();
  const expirationDate = new Date(currentDate);
  expirationDate.setFullYear(currentDate.getFullYear() + 1);

  await prismaClient.serviceToken.upsert({
    where: { token: "0000000000000000" },
    update: {
      expirationDate,
      description: "Startup service token",
    },
    create: {
      token: "0000000000000000",
      expirationDate,
      description: "Startup service token",
    },
  });
}

upsertData()
  .then(() => {
    console.log("Seed executed");
  })
  .catch((error) => {
    console.error("Seed failed:", error);
    process.exit(1);
  });
