package expo.modules.blueskyoauthclient

import android.util.Log
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoBlueskyOAuthClientModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoBlueskyOAuthClient")

    AsyncFunction("digest") { value: ByteArray ->
      return@AsyncFunction CryptoUtil().digest(value)
    }

    Function("getRandomValues") { byteLength: Int ->
      return@Function CryptoUtil().getRandomValues(byteLength)
    }

    AsyncFunction("generateJwk") { algorithim: String ->
      if (algorithim != "ES256") {
        throw Exception("Unsupported algorithm")
      }
      return@AsyncFunction CryptoUtil().generateKeyPair()
    }

    AsyncFunction("createJwt") { header: JWTHeader, payload: JWTPayload, jwk: JWK ->
      return@AsyncFunction JWTUtil().createJwt(header, payload, jwk)
    }

    AsyncFunction("verifyJwt") { token: String, jwk: JWK ->
      return@AsyncFunction JWTUtil().verifyJwt(token, jwk)
    }
  }
}