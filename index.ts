import * as IotlakePrisma from ".prisma/client/iotlake";
import * as BucketPrisma from ".prisma/client/bucket";

let iotlakePrismaClient: IotlakePrisma.PrismaClient | null = null;
let bucketPrismaClient: BucketPrisma.PrismaClient | null = null;

export function getIotlakePrismaClient(
  datasourceUrl: string,
  log?: IotlakePrisma.Prisma.LogLevel[]
): IotlakePrisma.PrismaClient {
  if (iotlakePrismaClient) return iotlakePrismaClient;
  iotlakePrismaClient = new IotlakePrisma.PrismaClient({ datasourceUrl, log });
  return iotlakePrismaClient;
}

export function getBucketPrismaClient(
  datasourceUrl: string,
  log?: BucketPrisma.Prisma.LogLevel[]
): BucketPrisma.PrismaClient {
  if (bucketPrismaClient) return bucketPrismaClient;
  bucketPrismaClient = new BucketPrisma.PrismaClient({ datasourceUrl, log });
  return bucketPrismaClient;
}

export { IotlakePrisma, BucketPrisma };
