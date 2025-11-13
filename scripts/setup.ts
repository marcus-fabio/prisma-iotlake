import * as fs from "fs";
import * as path from "path";
import { getSecret } from "../libs/secrets-manager";

async function generateEnvFile() {
  const deployEnvs = ["dev", "qa", "prod"] as const;
  const env = process.env.DEPLOY_STAGE as (typeof deployEnvs)[number];
  const isValidEnv = deployEnvs.includes(env);

  if (!isValidEnv) throw new Error(`Unknown environment: ${env}`);

  const iotlakeAdmin = await getSecret(`db/IoTLake/admin/${env}`);
  const iotlakeBuckets = await getSecret(`db/IoTLake/buckets/${env}`);

  const adminUser = encodeURIComponent(iotlakeAdmin.username);
  const adminPwd = encodeURIComponent(iotlakeAdmin.password);
  const bucketUser = encodeURIComponent(iotlakeBuckets.username);
  const bucketPwd = encodeURIComponent(iotlakeBuckets.password);

  const databaseUrl = `mysql://${adminUser}:${adminPwd}@${iotlakeAdmin.hostname}/${iotlakeAdmin.db}`;
  const bucketsUrl = `mysql://${bucketUser}:${bucketPwd}@${iotlakeBuckets.hostname}/${iotlakeBuckets.db}`;
  const envContent = `DATABASE_URL=${databaseUrl}\nBUCKETS_URL=${bucketsUrl}`;

  const envPath = path.join(__dirname, "../.env");
  fs.writeFileSync(envPath, envContent);

  console.log(`.env file generated at ${envPath}`);
}

generateEnvFile().catch((e) => {
  console.error(e);
  process.exit(1);
});
