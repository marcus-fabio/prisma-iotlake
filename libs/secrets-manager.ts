import {
  GetSecretValueCommand,
  SecretsManagerClient,
} from "@aws-sdk/client-secrets-manager";

export type SecretDatabase = {
  hostname: string;
  ro_hostname: string;
  username: string;
  password: string;
  db: string;
  max_pool: string;
  min_pool: string;
};

type SecretMapping = {
  "db/IoTLake/admin/dev": SecretDatabase;
  "db/IoTLake/admin/qa": SecretDatabase;
  "db/IoTLake/admin/prod": SecretDatabase;
  "db/IoTLake/buckets/dev": SecretDatabase;
  "db/IoTLake/buckets/qa": SecretDatabase;
  "db/IoTLake/buckets/prod": SecretDatabase;
};

type SecretName = keyof SecretMapping;

export async function getSecret<K extends SecretName>(
  secretName: K
): Promise<SecretMapping[K]> {
  try {
    const secretsManagerClient = new SecretsManagerClient({
      region: "us-east-1",
    });
    const command = new GetSecretValueCommand({
      SecretId: secretName,
      VersionStage: "AWSCURRENT",
    });
    const secretValue = await secretsManagerClient.send(command);

    if (secretValue.SecretString) {
      const parsedSecret = JSON.parse(secretValue.SecretString);
      return parsedSecret as SecretMapping[K];
    }
  } catch (error) {
    console.error("Error in connectWithSecretsManager:", error);
  }
}
