# What is this?
This repo contains a minimal reproduction of the issue with the OpenTelemetry javaagent as described in [#4496](https://github.com/open-telemetry/opentelemetry-java-instrumentation/discussions/4496)

# How do I run the repro?

Invoke the `run` Gradle target while injecting the OTel javaagent like so:

```bash
$ JAVA_TOOL_OPTIONS=-javaagent:$(pwd)/opentelemetry-javaagent.jar ./gradlew run
```

Or via the included Dockerfile:

```bash
$ docker build -t repro . && docker run repro
```

Expected output:
```bash
Picked up JAVA_TOOL_OPTIONS: -javaagent:/.../opentelemetry-javaagent.jar
OpenJDK 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended
[otel.javaagent 2021-10-26 14:14:36:340 -0400] [main] INFO io.opentelemetry.javaagent.tooling.VersionLogger - opentelemetry-javaagent - version: 1.7.0
Configuration on demand is an incubating feature.

> Task :app:run
Picked up JAVA_TOOL_OPTIONS: -javaagent:/.../opentelemetry-javaagent.jar
OpenJDK 64-Bit Server VM warning: Sharing is only supported for boot loader classes because bootstrap classpath has been appended
[otel.javaagent 2021-10-26 14:14:38:772 -0400] [main] INFO io.opentelemetry.javaagent.tooling.VersionLogger - opentelemetry-javaagent - version: 1.7.0
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
Exception in thread "main" java.util.concurrent.ExecutionException: io.rollout.client.Core$SetupException: Failed to initialize Rollout SDK
        at java.base/java.util.concurrent.FutureTask.report(FutureTask.java:122)
        at java.base/java.util.concurrent.FutureTask.get(FutureTask.java:191)
        at com.example.app.MainKt.main(Main.kt:6)
        at com.example.app.MainKt.main(Main.kt)
Caused by: io.rollout.client.Core$SetupException: Failed to initialize Rollout SDK
        at io.rollout.client.Core$1.a(SourceFile:266)
        at io.rollout.client.Core$1.call(SourceFile:210)
        at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
        at java.base/java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:304)
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1130)
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:630)
        at java.base/java.lang.Thread.run(Thread.java:832)
Caused by: java.util.concurrent.ExecutionException: java.lang.VerifyError: Inconsistent stackmap frames at branch target 38
Exception Details:
  Location:
    io/rollout/okio/AsyncTimeout$a.run()V @38: nop
  Reason:
    Type top (current frame, locals[2]) is not assignable to 'io/rollout/okio/AsyncTimeout$a' (stack map, locals[2])
  Current Frame:
    bci: @56
    flags: { }
    locals: { 'io/rollout/okio/AsyncTimeout$a', 'io/opentelemetry/javaagent/shaded/io/opentelemetry/context/Scope', top, 'io/rollout/okio/AsyncTimeout', 'java/lang/Class' }
    stack: { }
  Stackmap Frame:
    bci: @38
    flags: { }
    locals: { 'io/rollout/okio/AsyncTimeout$a', 'io/opentelemetry/javaagent/shaded/io/opentelemetry/context/Scope', 'io/rollout/okio/AsyncTimeout$a' }
    stack: { }
  Bytecode:
    0000000: 122d 122f b800 354c 2b2a b800 3ba7 0016
    0000010: 123d b800 435f 1245 5fb9 004b 0300 a700
    0000020: 0457 014c 2a4d 0012 0259 3a04 c2b8 0009
    0000030: 594e c700 0919 04c3 a7ff ee2d b200 08a6
    0000040: 000d 01b3 0008 1904 c3a7 001c 1904 c3a7
    0000050: 000b 3a05 1904 c319 05bf 2db6 000a a7ff
    0000060: c857 a7ff c401 4da7 0004 4d2b c600 092b
    0000070: b900 5001 00a7 0015 123d b800 435f 1245
    0000080: 5fb9 004b 0300 a700 0457 002c c600 052c
    0000090: bfb1
  Exception Handler Table:
    bci [45, 56] => handler: 82
    bci [59, 73] => handler: 82
    bci [76, 79] => handler: 82
    bci [82, 87] => handler: 82
    bci [38, 56] => handler: 97
    bci [59, 73] => handler: 97
    bci [76, 94] => handler: 97
    bci [0, 16] => handler: 16
    bci [38, 101] => handler: 106
    bci [107, 120] => handler: 120
    bci [16, 30] => handler: 33
    bci [120, 134] => handler: 137
  Stackmap Table:
    same_locals_1_stack_item_frame(@16,Object[#7])
    same_locals_1_stack_item_frame(@33,Object[#7])
    same_frame(@34)
    same_locals_1_stack_item_frame(@35,Object[#77])
    append_frame(@36,Object[#77])
    append_frame(@38,Object[#3])
    chop_frame(@39,1)
    append_frame(@59,Top,Object[#2],Object[#4])
    same_frame(@76)
    full_frame(@82,{Object[#3],Object[#77],Top,Top,Object[#4]},{Object[#7]})
    full_frame(@90,{Object[#3],Object[#77],Top,Object[#2]},{})
    full_frame(@97,{Object[#3],Object[#77]},{Object[#5]})
    full_frame(@101,{Object[#3],Object[#77]},{})
    same_locals_1_stack_item_frame(@106,Object[#7])
    append_frame(@107,Object[#7])
    same_frame(@117)
    same_locals_1_stack_item_frame(@120,Object[#7])
    same_locals_1_stack_item_frame(@137,Object[#7])
    same_frame(@138)
    same_frame(@139)
    same_frame(@145)

        at java.base/java.util.concurrent.FutureTask.report(FutureTask.java:122)
        at java.base/java.util.concurrent.FutureTask.get(FutureTask.java:191)
        at io.rollout.client.Core$1.a(SourceFile:214)
        ... 6 more
Caused by: java.lang.VerifyError: Inconsistent stackmap frames at branch target 38
Exception Details:
  Location:
    io/rollout/okio/AsyncTimeout$a.run()V @38: nop
  Reason:
    Type top (current frame, locals[2]) is not assignable to 'io/rollout/okio/AsyncTimeout$a' (stack map, locals[2])
  Current Frame:
    bci: @56
    flags: { }
    locals: { 'io/rollout/okio/AsyncTimeout$a', 'io/opentelemetry/javaagent/shaded/io/opentelemetry/context/Scope', top, 'io/rollout/okio/AsyncTimeout', 'java/lang/Class' }
    stack: { }
  Stackmap Frame:
    bci: @38
    flags: { }
    locals: { 'io/rollout/okio/AsyncTimeout$a', 'io/opentelemetry/javaagent/shaded/io/opentelemetry/context/Scope', 'io/rollout/okio/AsyncTimeout$a' }
    stack: { }
  Bytecode:
    0000000: 122d 122f b800 354c 2b2a b800 3ba7 0016
    0000010: 123d b800 435f 1245 5fb9 004b 0300 a700
    0000020: 0457 014c 2a4d 0012 0259 3a04 c2b8 0009
    0000030: 594e c700 0919 04c3 a7ff ee2d b200 08a6
    0000040: 000d 01b3 0008 1904 c3a7 001c 1904 c3a7
    0000050: 000b 3a05 1904 c319 05bf 2db6 000a a7ff
    0000060: c857 a7ff c401 4da7 0004 4d2b c600 092b
    0000070: b900 5001 00a7 0015 123d b800 435f 1245
    0000080: 5fb9 004b 0300 a700 0457 002c c600 052c
    0000090: bfb1
  Exception Handler Table:
    bci [45, 56] => handler: 82
    bci [59, 73] => handler: 82
    bci [76, 79] => handler: 82
    bci [82, 87] => handler: 82
    bci [38, 56] => handler: 97
    bci [59, 73] => handler: 97
    bci [76, 94] => handler: 97
    bci [0, 16] => handler: 16
    bci [38, 101] => handler: 106
    bci [107, 120] => handler: 120
    bci [16, 30] => handler: 33
    bci [120, 134] => handler: 137
  Stackmap Table:
    same_locals_1_stack_item_frame(@16,Object[#7])
    same_locals_1_stack_item_frame(@33,Object[#7])
    same_frame(@34)
    same_locals_1_stack_item_frame(@35,Object[#77])
    append_frame(@36,Object[#77])
    append_frame(@38,Object[#3])
    chop_frame(@39,1)
    append_frame(@59,Top,Object[#2],Object[#4])
    same_frame(@76)
    full_frame(@82,{Object[#3],Object[#77],Top,Top,Object[#4]},{Object[#7]})
    full_frame(@90,{Object[#3],Object[#77],Top,Object[#2]},{})
    full_frame(@97,{Object[#3],Object[#77]},{Object[#5]})
    full_frame(@101,{Object[#3],Object[#77]},{})
    same_locals_1_stack_item_frame(@106,Object[#7])
    append_frame(@107,Object[#7])
    same_frame(@117)
    same_locals_1_stack_item_frame(@120,Object[#7])
    same_locals_1_stack_item_frame(@137,Object[#7])
    same_frame(@138)
    same_frame(@139)
    same_frame(@145)

        at io.rollout.okio.AsyncTimeout.a(SourceFile:88)
        at io.rollout.okio.AsyncTimeout.enter(SourceFile:80)
        at io.rollout.okhttp3.internal.http2.Http2Stream.takeResponseHeaders(SourceFile:140)
        at io.rollout.okhttp3.internal.http2.Http2Codec.readResponseHeaders(SourceFile:125)
        at io.rollout.okhttp3.internal.http.CallServerInterceptor.intercept(SourceFile:88)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.connection.ConnectInterceptor.intercept(SourceFile:45)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:121)
        at io.rollout.okhttp3.internal.cache.CacheInterceptor.intercept(SourceFile:93)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:121)
        at io.rollout.okhttp3.internal.http.BridgeInterceptor.intercept(SourceFile:93)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.http.RetryAndFollowUpInterceptor.intercept(SourceFile:125)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:121)
        at io.rollout.networking.HttpClientFactory$a.intercept(SourceFile:112)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:147)
        at io.rollout.okhttp3.internal.http.RealInterceptorChain.proceed(SourceFile:121)
        at io.rollout.internal.g.a(SourceFile:200)
        at io.rollout.internal.g.execute(SourceFile:77)
        at io.rollout.networking.RequestSender.sendRequest(SourceFile:30)
        at io.rollout.configuration.ConfigurationFetcher.fetch(SourceFile:1082)
        at io.rollout.client.Client.a(SourceFile:190)
        at io.rollout.client.Client.a(SourceFile:186)
        at io.rollout.client.Client$1.a(SourceFile:145)
        at io.rollout.client.Client$1.call(SourceFile:141)
        at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
        ... 1 more
```