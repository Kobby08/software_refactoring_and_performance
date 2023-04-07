public class sample {

import java.util.concurrent.TimeUnit;

import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;

@State(Scope.Benchmark)@Fork(1)@Warmup(iterations=3,time=1)@Measurement(iterations=5,time=2)@BenchmarkMode(Mode.AverageTime)@OutputTimeUnit(TimeUnit.MICROSECONDS)}
