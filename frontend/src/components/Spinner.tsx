interface SpinnerProps {
  size?: number;
}

export function Spinner({ size = 16 }: SpinnerProps) {
  return (
    <span
      className="spinner-icon"
      style={{ width: size, height: size }}
      aria-hidden="true"
    />
  );
}
