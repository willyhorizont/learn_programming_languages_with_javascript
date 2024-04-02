Module Program
    Sub Main(Args As String())
        ' while loop

        Dim I1 As Integer = 1
        While (true)
            If (I1 = 2) Then
                If (I1 >= 5) Then Exit While
                I1 += 1
                Continue While
            End If
            Console.WriteLine($"while loop v1, I1 is {I1}")
            If (I1 >= 5) Then Exit While
            I1 += 1
        End While

        Dim I2 As Integer = 1
        While (I2 <= 5)
            If (I2 = 2) Then
                I2 += 1
                Continue While
            End If
            Console.WriteLine($"while loop v2, I2 is {I2}")
            I2 += 1
        End While

        ' for loop

        For I3 As Integer = 1 To 10 Step 1
            If (I3 > 5) Then Exit For
            If (I3 = 2) Then Continue For
            Console.WriteLine($"for loop ascending, I3 is {I3}")
        Next

        For I4 As Integer = 10 To 1 Step -1
            If (I4 <= 5) Then Exit For
            If (I4 = 9) Then Continue For
            Console.WriteLine($"for loop descending, I4 is {I4}")
        Next

        ' forEach loop

        For Each I5 As Integer In Enumerable.Range(1, 10)
            If (I5 > 5) Then Exit For
            If (I5 = 2) Then Continue For
            Console.WriteLine($"forEach loop ascending, I5 is {I5}")
        Next

        For Each I6 As Integer In Enumerable.Range(1, 10).Reverse()
            If (I6 <= 5) Then Exit For
            If (I6 = 9) Then Continue For
            Console.WriteLine($"forEach loop descending, I6 is {I6}")
        Next
    End Sub
End Module
