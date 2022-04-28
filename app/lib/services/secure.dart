import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/profile.dart';
import 'package:flutter_application_1/views/directory_page.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:ssl_pinning_plugin/ssl_pinning_plugin.dart';

Future<SecurityContext> get globalContext async { 
  final sslCert1 = await rootBundle.load('/certificate.pem');
  SecurityContext sc = SecurityContext(withTrustedRoots: false);
  sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
  return sc;}

