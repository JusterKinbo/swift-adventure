//
//  LotteryEncrypt.m
//  DESStudy
//
//  Created by longhuihu on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#include <CommonCrypto/CommonCryptor.h>
#import "DESEncryptor.h"
#import "Base64Transcoder.h"

//const char basekey[] = {185,137,132,207,159,208,197,120,25,233,86,85,188,98,218,152,130,232,76,218,47,223,230,85};

const char basekey[] = { (Byte) 0xb9, (Byte)0x89, (Byte) 0x84, (Byte) 0xcf, (Byte) 0x9f, (Byte)0xd0, (Byte) 0xc5, 0x78, 0x19, (Byte) 0xe9,
    (Byte) 0x56, (Byte) 0x55,(Byte)0xbc, (Byte) 0x62, (Byte)0xda, (Byte)0x98, (Byte)0x82, (Byte)0e8, 0x4c, (Byte) 0xda,
    (Byte) 0x2f, (Byte)0xdf, (Byte)0xe6, 0x55};

static void generateStamp(char *outBuf,size_t length)
{
    srand([[NSDate date] timeIntervalSince1970]);
    for (int i=0; i<length; i++) {
        int scope = 'z'-'a'+1;
        int c = 'a'+rand()%scope;
        outBuf[i] = c;
    }
}

static void generateKey(const char *baseKey, size_t keyLength, const char *stamp, size_t stampLength, char *finalKey)
{
    int basePos = 0;
    int stampPos = 0;
    while (basePos<keyLength) {
        finalKey[basePos] = baseKey[basePos]&(stamp[stampPos]);
        basePos++;
        stampPos++;
        if (basePos>=keyLength) {
            break;
        }
        if (stampPos>=stampLength) {
            stampPos=0;
        }
        finalKey[basePos] = baseKey[basePos]|(stamp[stampPos]);
        basePos++;
        stampPos++;
        if (basePos>=keyLength) {
            break;
        }
        if (stampPos>=stampLength) {
            stampPos=0;
        }
        finalKey[basePos] = baseKey[basePos]^(stamp[stampPos]);
        basePos++;
        stampPos++;
        if (basePos>=keyLength) {
            break;
        }
        if (stampPos>=stampLength) {
            stampPos=0;
        }
    }
}

@implementation DESEncryptor

+ (NSString*)generateStamp {
    char stamp[21];
    size_t stampLength = 8+rand()%13;
    generateStamp(stamp,stampLength);
    stamp[stampLength]= 0;
    return [NSString stringWithUTF8String:stamp];
}

+(NSData*)encyptPostData:(NSData *)data withStamp:(NSString*)stampString
{
    NSMutableData *encryptedData = [NSMutableData dataWithCapacity:128];
    
    //PKCS5 padding
    const char*rawbyters = [data bytes];
    size_t rawlength = [data length];
    size_t padlength = rawlength%8;
    padlength = 8-padlength;
    size_t lengthAfterPad = rawlength+padlength;
    void *paddedBytes = malloc(lengthAfterPad);
    memcpy(paddedBytes, rawbyters,rawlength);
    memset(paddedBytes+rawlength,(int)padlength,padlength);
    
    char *encyptBytes = malloc(lengthAfterPad);
    size_t numBytesEncrypted;
    
    const char * stamp = [stampString cStringUsingEncoding:NSUTF8StringEncoding];
    size_t stampLength = strlen(stamp);
    
    char key[24];
    generateKey(basekey,24,stamp,stampLength,key);
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt,kCCAlgorithm3DES , kCCOptionECBMode, key, kCCKeySize3DES,NULL, paddedBytes, lengthAfterPad, encyptBytes, lengthAfterPad, &numBytesEncrypted);
    if (status==kCCSuccess) {
        size_t base64length = EstimateBas64EncodedDataSize(numBytesEncrypted);
        char *base64Buffer = malloc(base64length);
        Base64EncodeData(encyptBytes,numBytesEncrypted,base64Buffer,&base64length);
        [encryptedData appendBytes:base64Buffer length:base64length];
        free(base64Buffer);
    }
    free(paddedBytes);
    free(encyptBytes);
    return encryptedData;
}

+ (NSData *)decryptPostData:(NSData*)encryptData withStamp:(NSString*)stampString {
    
    NSMutableData *encryptedData = [NSMutableData dataWithCapacity:128];
    
    char key[24];
    NSData* stamp = [stampString dataUsingEncoding:NSUTF8StringEncoding];
    NSData* data = encryptData;
    generateKey(basekey,24,[stamp bytes],[stamp length],key);
    
    char * unBase64Buffer = malloc([data length]+1);
    size_t unBase64BufferLength = [data length]+1;
    Base64DecodeData([data bytes],[data length],unBase64Buffer,&unBase64BufferLength);
    unBase64Buffer[unBase64BufferLength] = 0;
    
    char * decryptBuffer = malloc([data length]+1);
    size_t decryptBufferLength = 0;
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt,kCCAlgorithm3DES , kCCOptionECBMode, key, kCCKeySize3DES,NULL, unBase64Buffer, unBase64BufferLength, decryptBuffer, unBase64BufferLength, &decryptBufferLength);
    if (status==kCCSuccess) {
        int padlength = decryptBuffer[decryptBufferLength-1];
        [encryptedData appendBytes:decryptBuffer length:decryptBufferLength-padlength];
    }
    free(unBase64Buffer);
    free(decryptBuffer);
    return encryptedData;
}

@end

